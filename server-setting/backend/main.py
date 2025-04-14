import os
import json
import paramiko
import tempfile
from typing import Dict, Optional, List
from fastapi import FastAPI, UploadFile, File, HTTPException, Form
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn
from fastapi.staticfiles import StaticFiles
from fastapi.responses import JSONResponse, HTMLResponse, RedirectResponse
from fastapi import Request
import time

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # For development. Restrict in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Path for config storage
CONFIG_PATH = "../config/info.json"
FRONTEND_DIR = "../frontend/dist"


# Model for connection request
class ConnectionRequest(BaseModel):
    url: str
    username: str
    pem_path: str


# Model for execution request
class ExecutionRequest(BaseModel):
    command: str


# Model for SSH key generation request
class SSHKeyRequest(BaseModel):
    email: str


# SSH connection singleton
ssh_client = None
ssh_connected = False


def ensure_config_dir():
    """Ensure the config directory exists"""
    os.makedirs(os.path.dirname(CONFIG_PATH), exist_ok=True)


def save_connection_details(details: dict):
    """Save connection details to config file"""
    ensure_config_dir()
    with open(CONFIG_PATH, "w") as f:
        json.dump(details, f)


def load_connection_details():
    """Load connection details from config file"""
    if not os.path.exists(CONFIG_PATH):
        return None
    with open(CONFIG_PATH, "r") as f:
        return json.load(f)


# === STEP 1: SSH Connection ===
def connect_ssh(host, username, key_path):
    """Connect to the EC2 instance via SSH"""
    global ssh_client, ssh_connected

    try:
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh_client.connect(hostname=host, username=username, key_filename=key_path)
        ssh_connected = True
        return True
    except Exception as e:
        print(f"SSH connection error: {str(e)}")
        ssh_connected = False
        return False


def execute_command(command):
    """Execute a command on the EC2 instance"""
    global ssh_client, ssh_connected

    if not ssh_connected or ssh_client is None:
        raise HTTPException(status_code=400, detail="Not connected to SSH server")

    try:
        stdin, stdout, stderr = ssh_client.exec_command(command)
        result = stdout.read().decode("utf-8")
        error = stderr.read().decode("utf-8")
        return {"success": error == "", "output": result, "error": error}
    except Exception as e:
        return {"success": False, "output": "", "error": str(e)}


@app.get("/api")
def read_api_root():
    return {"message": "EC2 Repository Manager API is running"}


@app.get("/")
async def root():
    """Redirect root requests to the frontend"""
    return RedirectResponse(url="/index.html")


@app.post("/api/connect")
async def connect(connection: ConnectionRequest):
    """Test and save connection to EC2 instance"""
    success = connect_ssh(connection.url, connection.username, connection.pem_path)

    if success:
        save_connection_details(
            {
                "url": connection.url,
                "username": connection.username,
                "pem_path": connection.pem_path,
            }
        )
        return {
            "status": "connected",
            "message": "Successfully connected to EC2 instance",
        }
    else:
        return {"status": "failed", "message": "Failed to connect to EC2 instance"}


@app.post("/api/upload-key")
async def upload_key(key_file: UploadFile = File(...)):
    """Handle PEM key file upload"""
    temp_dir = tempfile.gettempdir()
    temp_file_path = os.path.join(temp_dir, key_file.filename)

    with open(temp_file_path, "wb") as f:
        contents = await key_file.read()
        f.write(contents)

    # Set proper permissions for the key file
    os.chmod(temp_file_path, 0o600)

    return {"status": "success", "file_path": temp_file_path}


@app.get("/api/connection-status")
def connection_status():
    """Check the current connection status"""
    details = load_connection_details()
    return {"connected": ssh_connected, "details": details}


@app.post("/api/execute-step")
def execute_step(request: ExecutionRequest):
    """Execute a command for a specific step"""
    result = execute_command(request.command)
    return result


# === STEP 2: System Preparation ===
@app.post("/api/system-preparation")
def system_preparation():
    """Execute system preparation commands, skipping if recently updated."""
    skipped = False
    results = []
    one_week_seconds = 7 * 24 * 60 * 60

    # Check the timestamp of the last successful update
    # Use "|| echo 0" to handle cases where the file doesn't exist or stat fails
    get_stamp_cmd = "stat -c %Y /var/lib/apt/periodic/update-success-stamp || echo 0"
    stamp_result = execute_command(get_stamp_cmd)

    last_update_time = 0
    if stamp_result["success"] and stamp_result["output"].strip().isdigit():
        last_update_time = int(stamp_result["output"].strip())

    current_time = time.time()

    if last_update_time > 0 and (current_time - last_update_time) < one_week_seconds:
        skipped = True
        results.append(
            {
                "success": True,
                "output": f"System package lists updated within the last week ({(current_time - last_update_time)/3600:.1f} hours ago). Skipping update/upgrade/install.",
                "error": "",
            }
        )
        print("System preparation skipped: Updated recently.")
    else:
        print("Running system preparation: apt update, upgrade, install git.")
        # Set DEBIAN_FRONTEND to noninteractive to prevent prompts
        update_cmd = "sudo DEBIAN_FRONTEND=noninteractive apt-get update -y"
        upgrade_cmd = "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y"
        # Ensure git is installed even if update/upgrade were skipped previously but git wasn't installed
        install_cmd = "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git"

        results.extend(
            [
                execute_command(update_cmd),
                execute_command(upgrade_cmd),
                execute_command(install_cmd),
            ]
        )

    return {"results": results, "skipped": skipped}


# === New Endpoint: Check Git User Existence ===
@app.post("/api/check-git-user")
def check_git_user():
    """Check if the 'git' user exists on the system."""
    check_user_cmd = "id -u git"
    check_result = execute_command(check_user_cmd)
    user_exists = check_result["success"]  # Command succeeds if user exists
    return {"user_exists": user_exists}


# === STEP 3: Git User Setup (Now only Overwrite/Create) ===
@app.post("/api/git-user-setup")
def git_user_setup(password: str = Form(...)):
    """Set up git user with provided password (overwrites if exists)."""
    # Remove existing user if exists (ignore errors if not found)
    # This ensures a clean state for creation or overwrite
    remove_result = execute_command("sudo userdel -r git || true")

    # Create user
    user_result = execute_command("sudo useradd -m -d /home/git -s /bin/bash git")

    # Add to sudo group
    sudo_result = execute_command("sudo usermod -aG sudo git")

    # Set password (using echo pipe to avoid terminal prompt)
    pass_cmd = f"echo 'git:{password}' | sudo chpasswd"
    pass_result = execute_command(pass_cmd)

    return {
        # No 'skipped' flag needed here anymore
        "remove_result": remove_result,
        "user_result": user_result,
        "sudo_result": sudo_result,
        "password_result": pass_result,
    }


# === STEP 4: SSH Configuration ===
@app.post("/api/ssh-configuration")
def ssh_configuration():
    """Set up SSH configuration for git user"""
    results = [
        execute_command("sudo mkdir -p /home/git/.ssh"),
        execute_command("sudo chmod 700 /home/git/.ssh"),
        execute_command("sudo touch /home/git/.ssh/authorized_keys"),
        execute_command("sudo chmod 600 /home/git/.ssh/authorized_keys"),
        execute_command("sudo chown -R git:git /home/git"),
        execute_command("sudo chown -R git:git /home/git/.ssh"),
    ]
    return {"results": results}


# === STEP 5: SSH Key Management ===
@app.post("/api/ssh-key-management")
def ssh_key_management(request: SSHKeyRequest):
    """Generate and set up SSH keys"""
    # Generate keys

    # Append authorized keys
    append_cmd = (
        "cat ~/.ssh/authorized_keys | sudo tee -a /home/git/.ssh/authorized_keys"
    )
    append_result = execute_command(append_cmd)
    print(f"results: {append_result}")

    return {
        "results": [append_result],
    }


# === STEP 6: Repository Setup ===
@app.post("/api/repository-setup")
def repository_setup():
    """Set up git repository on server"""
    results = [
        execute_command("sudo mkdir -p /home/git/repos"),
        execute_command("sudo chown -R git:git /home/git/repos"),
        execute_command("sudo git init --bare /home/git/repos/dhg503-project.git"),
        execute_command("sudo git config --global init.defaultBranch main"),
    ]
    print(f"repository_setup results: {results}")
    return {"results": results}


# === STEP 7: Docker Setup ===
@app.post("/api/docker-setup")
def docker_setup():
    """Install Docker Engine, CLI, containerd, buildx, and Compose plugin."""
    results = []

    # --- Phase 1: Prerequisites and GPG Key ---
    commands_phase1 = [
        "sudo apt-get update -y",
        "sudo apt-get install -y ca-certificates curl",
        "sudo install -m 0755 -d /etc/apt/keyrings",
        "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc",
        "sudo chmod a+r /etc/apt/keyrings/docker.asc",
    ]
    for cmd in commands_phase1:
        result = execute_command(cmd)
        results.append(result)
        if not result["success"]:
            print(f"Docker setup failed at phase 1: {cmd}. Error: {result['error']}")
            return {"results": results}  # Return early on failure

    # --- Phase 2: Add Docker Repository ---
    # Combine getting variables and writing the source list into one logical step
    # Use bash -c to ensure variable scope and handle potential errors within the sequence
    add_repo_cmd = """
    bash -c '
    ARCH=$(dpkg --print-architecture) && \
    CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME") && \
    echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    '
    """
    # Strip leading/trailing whitespace and newlines from the command string
    add_repo_cmd = add_repo_cmd.strip()

    result = execute_command(add_repo_cmd)
    results.append(result)
    if not result["success"]:
        print(f"Docker setup failed adding repo. Error: {result['error']}")
        # Attempt cleanup of potentially broken list file before returning
        execute_command("sudo rm -f /etc/apt/sources.list.d/docker.list")
        return {"results": results}

    # --- Phase 3: Install Docker Components ---
    commands_phase3 = [
        "sudo apt-get update -y",
        "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
        "sudo usermod -aG docker $USER",
        'sudo curl -Ls "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose',
        "sudo chmod +x /usr/local/bin/docker-compose",
    ]
    for cmd in commands_phase3:
        result = execute_command(cmd)
        results.append(result)
        # Log warnings but don't hard fail phase 3 for now
        if not result["success"]:
            print(
                f"Warning: Docker setup command failed at phase 3: {cmd}. Error: {result['error']}"
            )

    print(f"docker_setup results: {results}")
    return {"results": results}


# Check if the frontend dist directory exists
if os.path.exists(FRONTEND_DIR):
    # Mount frontend static files
    app.mount("/", StaticFiles(directory=FRONTEND_DIR, html=True), name="static")
else:
    print(
        f"Warning: Frontend directory {FRONTEND_DIR} not found. The UI won't be served."
    )

    # Define a root handler to show an error message
    @app.get("/", response_class=HTMLResponse)
    async def read_root():
        return """
        <html>
            <head>
                <title>Frontend Not Built</title>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; padding: 20px; max-width: 800px; margin: 0 auto; }
                    .error { color: #e53e3e; padding: 20px; border-radius: 5px; border: 1px solid #e53e3e; background-color: #fff5f5; }
                    code { background-color: #edf2f7; padding: 2px 4px; border-radius: 3px; }
                </style>
            </head>
            <body>
                <h1>Frontend Not Built</h1>
                <div class="error">
                    <p>The frontend application has not been built yet or could not be found at <code>../frontend/dist</code>.</p>
                    <p>Please run the following commands to build the frontend:</p>
                    <pre>
cd frontend
yarn
yarn build
                    </pre>
                    <p>Then restart the server to access the application.</p>
                </div>
                <p>API Status: <strong>Running</strong> - API endpoints are available at /api/*</p>
            </body>
        </html>
        """


if __name__ == "__main__":
    print(f"Starting server on http://localhost:80")
    print(f"API available at http://localhost:80/api")
    if os.path.exists(FRONTEND_DIR):
        print(f"Frontend UI available at http://localhost:80")
    uvicorn.run("main:app", host="0.0.0.0", port=8888, reload=True)
