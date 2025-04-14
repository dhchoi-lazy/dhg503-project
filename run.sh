#!/bin/bash

# AWS EC2 Repository Manager Run Script
# This script sets up the Python environment and runs the application

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}==============================================${NC}"
echo -e "${BLUE}   AWS EC2 Repository Manager Runner         ${NC}"
echo -e "${BLUE}==============================================${NC}"

# Find a working Python 3 command
PYTHON_CMD=""
if command -v python3 &> /dev/null; then
    # Test if this python3 is functional
    if python3 -c "import sys" &> /dev/null; then
        PYTHON_CMD="python3"
    else
        echo -e "${YELLOW}Warning: 'python3' command found but seems non-functional (might be Windows Store alias). Trying 'python'...${NC}"
    fi
fi

# If python3 wasn't functional or not found, try 'python'
if [ -z "$PYTHON_CMD" ] && command -v python &> /dev/null; then
    # Check if 'python' is Python 3 and functional
    py_version=$("python" -V 2>&1)
    if [[ $py_version == "Python 3"* ]]; then
        if python -c "import sys" &> /dev/null; then
            PYTHON_CMD="python"
        else
            echo -e "${YELLOW}Warning: 'python' command found and is Python 3, but seems non-functional.${NC}"
        fi
    fi
fi

if [ -z "$PYTHON_CMD" ]; then
    echo -e "${RED}Could not find a functional Python 3 interpreter on PATH (checked 'python3' and 'python').${NC}"
    echo -e "${YELLOW}Please install Python 3.8 or later and ensure it is added to your PATH.${NC}"
    echo -e "${YELLOW} * On Windows, ensure it's not the Microsoft Store alias or disable the alias.${NC}"
    echo -e "${YELLOW} * On Debian/Ubuntu, ensure 'python3' is installed.${NC}"
    echo -e "${YELLOW}Download from: https://www.python.org/downloads/${NC}"
    exit 1
else
     echo -e "${GREEN}Using functional Python command: $PYTHON_CMD${NC}"
     # Optional: Add a version check here if needed
     # "$PYTHON_CMD" -c "import sys; sys.exit(not (sys.version_info >= (3, 8)))"
     # if [ $? -ne 0 ]; then ... exit ... fi
fi

# Step 1: Set up virtual environment and install backend dependencies
echo -e "\n${GREEN}Step 1: Setting up virtual environment and installing backend dependencies...${NC}"

# Define VENV paths early based on OS for the check later
VENV_DIR=".venv"
VENV_BIN_DIR="$VENV_DIR/bin" # Default for Linux/Darwin
VENV_ACTIVATE_SCRIPT="activate"
if [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    VENV_BIN_DIR="$VENV_DIR/Scripts"
    # activate script name is the same, but path differs
fi
VENV_ACTIVATE_PATH="$VENV_BIN_DIR/$VENV_ACTIVATE_SCRIPT"

# Create virtual environment if it doesn't exist or seems incomplete
venv_ok=false
if [ -d "$VENV_DIR" ] && [ -f "$VENV_ACTIVATE_PATH" ]; then
    echo -e "${BLUE}Virtual environment '$VENV_DIR' already exists and seems complete.${NC}"
    venv_ok=true
else
    echo -e "${BLUE}Creating or refreshing virtual environment in '$VENV_DIR' using '$PYTHON_CMD -m venv'...${NC}"
    # Remove potentially incomplete venv dir before creating
    if [ -d "$VENV_DIR" ]; then
      echo -e "${YELLOW}Removing existing potentially incomplete '$VENV_DIR'...${NC}"
      rm -rf "$VENV_DIR"
    fi

    venv_error_log="venv_creation_error.log"
    "$PYTHON_CMD" -m venv "$VENV_DIR" 2> "$venv_error_log"
    venv_exit_code=$?

    if [ $venv_exit_code -ne 0 ]; then
        echo -e "${RED}Failed to create virtual environment (Exit code: $venv_exit_code).${NC}"
        error_output=$(cat "$venv_error_log")
        is_debian_ubuntu=false
        is_windows=false
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
             if [ -f /etc/debian_version ] || grep -qi "debian" /etc/os-release || grep -qi "ubuntu" /etc/os-release; then
                 is_debian_ubuntu=true
             fi
        elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
            is_windows=true
        fi

        # Check for Ubuntu/Debian 'ensurepip' error specifically
        if $is_debian_ubuntu && echo "$error_output" | grep -q "ensurepip"; then
             # Try to extract the specific package suggestion if available
             suggested_package=$(echo "$error_output" | grep -o 'python3\.[0-9.]*-venv' | head -n 1)
             # Fallback if specific version not found in the message
             if [ -z "$suggested_package" ]; then
                 suggested_package="python3-venv" # Default guess
             fi
             echo -e "${YELLOW}The error suggests the Python venv module (ensurepip) is missing.${NC}"
             echo -e "${YELLOW}On Debian/Ubuntu, this usually requires the '$suggested_package' package.${NC}"
             echo -e "${YELLOW}Would you like to attempt to install it using 'sudo apt install'? (y/n)${NC}"
             read -r install_venv_choice

             if [[ $install_venv_choice == "y" || $install_venv_choice == "Y" ]]; then
                 echo -e "${BLUE}Attempting to install $suggested_package...${NC}"
                 sudo apt update && sudo apt install -y "$suggested_package"
                 install_exit_code=$?
                 if [ $install_exit_code -eq 0 ]; then
                     echo -e "${GREEN}$suggested_package installation command executed successfully.${NC}"
                     echo -e "${YELLOW}Please re-run this script to create the virtual environment.${NC}"
                     rm -f "$venv_error_log"
                     exit 0
                 else
                     echo -e "${RED}Failed to install $suggested_package (Exit code: $install_exit_code).${NC}"
                     echo -e "${RED}Please install it manually.${NC}"
                 fi
             else
                  echo -e "${YELLOW}Skipping installation of $suggested_package.${NC}"
             fi
        fi
        # Check for Windows 'Python was not found' error
        if $is_windows && echo "$error_output" | grep -q "Python was not found"; then
            echo -e "${YELLOW}Hint: On Windows, this error often occurs if the '$PYTHON_CMD' command executes the Microsoft Store alias instead of a full Python installation.${NC}"
            echo -e "${YELLOW}Please ensure a full Python 3 installation (from python.org or elsewhere) is available and prioritized in your PATH, or disable the 'App execution aliases' for Python in Windows Settings.${NC}"
        fi
        echo -e "${RED}Virtual environment creation error details:${NC}"
        echo "$error_output"
        rm -f "$venv_error_log"
        exit 1
    else
        # Venv command exit code was 0, BUT verify activation script exists
        if [ ! -f "$VENV_ACTIVATE_PATH" ]; then
             echo -e "${RED}Virtual environment created (exit code 0), but activation script '$VENV_ACTIVATE_PATH' is missing!${NC}"
             if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                 if [ -f /etc/debian_version ] || grep -qi "debian" /etc/os-release || grep -qi "ubuntu" /etc/os-release; then
                      echo -e "${YELLOW}On Debian/Ubuntu systems, this usually means the 'python3-venv' package is not installed.${NC}"
                      echo -e "${YELLOW}Please try installing it: sudo apt update && sudo apt install python3-venv${NC}"
                 fi
             fi
             echo -e "${RED}Cannot proceed without a valid virtual environment.${NC}"
             rm -f "$venv_error_log" # Clean up log file if it exists
             exit 1
        else
             echo -e "${GREEN}Virtual environment created successfully in '$VENV_DIR'.${NC}"
             venv_ok=true
             rm -f "$venv_error_log" # Clean up log file if it exists
        fi
    fi
fi # End of venv creation/check block

# Abort if venv setup wasn't successful for any reason
if ! $venv_ok; then
    echo -e "${RED}Virtual environment setup failed or was skipped. Cannot proceed.${NC}"
    exit 1
fi

# Activate virtual environment (platform-specific)
# Note: Paths ($VENV_ACTIVATE_PATH) are already defined above
echo -e "${BLUE}Activating virtual environment: source $VENV_ACTIVATE_PATH${NC}"
if [ -f "$VENV_ACTIVATE_PATH" ]; then
    source "$VENV_ACTIVATE_PATH"
else
    # This check should theoretically be redundant now due to earlier checks, but kept as a safeguard
    echo -e "${RED}Virtual environment activation script not found: $VENV_ACTIVATE_PATH${NC}"
    echo -e "${RED}Cannot proceed without activating the virtual environment.${NC}"
    exit 1
fi

# Install dependencies using the virtual environment's python/pip
# Use $PYTHON_CMD which should be python/python3 from the *activated* venv now
echo -e "${BLUE}Attempting to install dependencies using '$PYTHON_CMD -m pip' from activated virtual environment...${NC}"
"$PYTHON_CMD" -m pip install --upgrade pip # Ensure pip is up-to-date within venv
"$PYTHON_CMD" -m pip install -r requirements-server.txt
pip_exit_code=$?

# Check final status
if [ $pip_exit_code -ne 0 ]; then
    echo -e "${RED}Failed to install dependencies from requirements-server.txt using '$PYTHON_CMD -m pip' (Exit code: $pip_exit_code).${NC}"
    # Check if the error is related to missing Rust/Cargo
    # Capture pip's error output if possible (might require redirecting stderr from pip command)
    # For simplicity, we'll just check the exit code here and provide general + specific hints.
    # A more robust solution would capture stderr from the pip command above.
    echo -e "${YELLOW}Checking common installation issues...${NC}"
    if [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
         echo -e "${YELLOW}Hint: Some Python packages require build tools. On Windows, you might need Microsoft C++ Build Tools (available via Visual Studio Installer).${NC}"
         echo -e "${YELLOW}Hint: If the error mentions 'Rust' or 'Cargo', you need to install the Rust toolchain from https://rustup.rs/${NC}"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
         echo -e "${YELLOW}Hint: Some Python packages require build tools. On Debian/Ubuntu, you might need 'build-essential' and 'python3-dev' (e.g., sudo apt install build-essential python3-dev).${NC}"
         echo -e "${YELLOW}Hint: If the error mentions 'Rust' or 'Cargo', you need to install the Rust toolchain. Often 'sudo apt install cargo' works, or use the recommended method from https://rustup.rs/${NC}"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
         echo -e "${YELLOW}Hint: Some Python packages require build tools. On macOS, you might need Xcode Command Line Tools (run 'xcode-select --install').${NC}"
         echo -e "${YELLOW}Hint: If the error mentions 'Rust' or 'Cargo', you need to install the Rust toolchain from https://rustup.rs/${NC}"
    fi
    echo -e "${RED}Please check the error messages above, requirements-server.txt, and your network connection.${NC}"
    exit 1
else
    echo -e "${GREEN}Dependencies installed successfully.${NC}"
fi

# Step 2: Create config directory if it doesn't exist
echo -e "\n${GREEN}Step 2: Creating config directory if needed...${NC}"
mkdir -p config
if [ ! -f config/info.json ]; then
    echo "{}" > config/info.json
    echo -e "${BLUE}Created empty info.json file${NC}"
fi

# Step 3: Start frontend static server
echo -e "\n${GREEN}Step 3: Starting frontend static file server on port 80...${NC}"
echo -e "${YELLOW}Note: Running on port 80 may require administrator/root privileges.${NC}"
if [ -d "server-setting/frontend/dist" ]; then
    cd server-setting/frontend/dist || { echo -e "${RED}Failed to enter server-setting/frontend/dist directory!${NC}"; exit 1; }
    echo -e "${BLUE}Serving files from $(pwd) on port 80 in the background using activated venv python...${NC}"

    # Use python from the activated virtual environment (should be in PATH)
    if command -v python &> /dev/null; then
        echo -e "${BLUE}Using python command found in PATH (expected from venv): $(command -v python)${NC}"
        if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
             # Use python from PATH
             start /B "" python -m http.server 80 &> frontend_server.log
        else
             # Use python from PATH
             nohup python -m http.server 80 &> frontend_server.log &
        fi
        FRONTEND_PID=$! # Note: Getting PID might be unreliable with 'start /B' on Windows
        echo -e "${GREEN}Frontend server started in background (PID: $FRONTEND_PID might be inaccurate on Windows). Log: $(pwd)/frontend_server.log${NC}"
    else
        echo -e "${RED}Could not find 'python' command in PATH even after activating virtual environment.${NC}"
        echo -e "${YELLOW}Cannot start frontend server.${NC}"
    fi
    cd ../../.. # Go back to project root
else
    echo -e "${YELLOW}Directory server-setting/frontend/dist not found. Skipping frontend server start.${NC}"
    echo -e "${YELLOW}Build the frontend application first (e.g., using 'npm run build' or 'yarn build' in server-setting/frontend).${NC}"
fi

# Step 4: Run backend server
echo -e "\n${GREEN}Step 4: Starting backend server...${NC}"
echo -e "${YELLOW}The frontend is available at http://localhost:80${NC}"
echo -e "${YELLOW}The backend API is running at http://localhost:8888${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop the backend server.${NC}"

# Use the python from the activated virtual environment
if command -v python &> /dev/null; then
    echo -e "${BLUE}Running backend server using: $(command -v python)${NC}"
    python server-setting/backend/main.py
else
    echo -e "${RED}Could not find 'python' command even after activating virtual environment.${NC}"
    echo -e "${RED}Something went wrong with the virtual environment setup or activation.${NC}"
    exit 1
fi

# Optional: Clean up background process on exit (may not work reliably across platforms)
# trap "echo 'Stopping frontend server...'; kill $FRONTEND_PID 2>/dev/null" EXIT 