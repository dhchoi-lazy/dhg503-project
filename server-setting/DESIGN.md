# AWS EC2 Repository Manager for Beginners

## Project Overview

This application provides a simple GUI interface for students to connect to AWS EC2 instances and manage Git repositories without using the command line. The app handles SSH connections, Git operations, and server management through an intuitive step-by-step interface. This app will be executed in the local machine only.

### Target Users

- Beginners learning AWS EC2 and Git workflows

## Technical Architecture

### Folder Structure

```
├── frontend/           # React application with TypeScript
│   ├── src/            # React components and TypeScript logic
│   │   ├── components/ # UI components
│   │   ├──── ui/ # shadcn UI components
│   │   ├── hooks/      # Custom React hooks
│   │   ├── types/      # TypeScript type definitions
│   │   ├── utils/      # utility functions
│   │   ├── api/        # API
│   │   └── App.tsx     # Main application component
│   ├── public/         # Static assets
│   ├── tsconfig.json   # TypeScript configuration
│   └── build/          # Built files (production)
├── backend/
│   ├── main.py         # Python server
│   └── requirements.txt # Python dependencies
├── README.md           # Setup instructions
├── DEVELOPMENT.md      # Development guide
├── DESIGN.md           # Design document
├── PROGRESS.md         # Development progress log
├── run.sh        # One-click build and run script
├── .venv/              # Python virtual environment
└── config/
    └── info.json       # Saved connection settings
```

### Technologies

- **Frontend**: React.js with TypeScript using Create React App and Tailwind CSS for a simple, intuitive UI
- **Backend**: Python (fastapi) for server operations and SSH command execution
- **Communication**: RESTful API between frontend and backend
- **Persistence**: Local JSON file for saving connection details
- **Environment Management**: Python virtual environment (.venv) with support for pip or uv

## Frontend Design

### Key Features

- **Step-by-Step Wizard Interface**: Clear navigation with prev/next buttons
- **Connection Setup Page**: Form to enter EC2 URL and PEM file location
- **Command Execution Pages**: Visual feedback for each server setup step
- **Status Indicators**: Progress tracking and success/error states

### User Flow

1. Welcome screen with app purpose explanation
2. AWS EC2 connection details entry form
3. Step-by-step system setup with visual progress indicators
4. Repository management operations
5. Success confirmation and next steps guidance

### Components

- Connection form with validation
- Interactive command execution panels
- Progress stepper component
- Status notifications
- Responsive layout for different screen sizes

## Backend Implementation

### Python Server (main.py)

The server will handle:

- SSH connections to EC2 instances
- Command execution and output capture
- File operations for PEM key handling
- Status tracking and error handling

### API Endpoints

```
POST /api/connect          # Test and save EC2 connection
POST /api/execute-step     # Run commands for specific step
GET  /api/connection-status # Check current connection state
POST /api/upload-key       # Handle PEM key file upload
```

### Dependencies

Backend dependencies are managed using pip or uv:

```
paramiko==3.3.1         # SSH connection handling
fastapi==0.103.1        # API framework
uvicorn==0.23.2         # ASGI server
cryptography==41.0.4    # Key handling
python-multipart==0.0.6 # Form data processing
pydantic==2.3.0         # Data validation
```

## Implementation Plan

### Step 1: Connection Setup

- Connect to the EC2 instance using the provided URL and PEM file
- Validate connection credentials and save for future use
- Display connection status to user

### Step 2: System Preparation

Execute and display results for:

```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git
```

### Step 3: Git User Setup

Execute and display results for:

```bash
sudo useradd -m -d /home/git -s /bin/bash git
sudo usermod -aG sudo git
sudo passwd git  # Handle password creation through UI
```

### Step 4: SSH Configuration

Execute and display results for:

```bash
sudo mkdir -p /home/git/.ssh
sudo chmod 700 /home/git/.ssh
sudo touch /home/git/.ssh/authorized_keys
sudo chmod 600 /home/git/.ssh/authorized_keys
sudo chown -R git:git /home/git
sudo chown -R git:git /home/git/.ssh
```

### Step 5: SSH Key Management

Execute and display results for:

```bash
# Generate keys if needed
ssh-keygen -t rsa -b 4096 -C "student@example.com" -f ~/.ssh/id_rsa -N ""

# Copy keys to git user
cat ~/.ssh/id_rsa.pub | sudo tee /home/git/.ssh/authorized_keys
cat ~/.ssh/authorized_keys | sudo tee -a /home/git/.ssh/authorized_keys
```

### Step 6: Repository Setup

Execute and display results for:

```bash
sudo mkdir -p /home/git/repos
sudo chown -R git:git /home/git/repos
sudo git init --bare /home/git/repos/dhg503-project.git
sudo git config --global init.defaultBranch main
```

### Step 7: Docker Setup

Execute and display results for:

```bash
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add the Docker repository:

```bash
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Add your user to the Docker group so you can run Docker commands without sudo:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Install Docker Compose:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Here's the cleaned-up and concise version without emojis:

---

# Uploading the Repository to the Server

## Step 1: Return to the Local Machine

Make sure you're back on your local development environment.

## Step 2: Locate the Repository Directory

- Default path: `~/Github/dhg503-project`
- Or change it via the **Select Repository** button.

## Step 3: Change Directory

```bash
cd ~/Github/dhg503-project
```

## Step 4: Upload to the Server

Reset the remote and push:

```bash
git remote remove origin
git remote add origin git@${awsUrl}:/home/git/repos/dhg503-project.git
git add -A
git commit -m "random commit"
git push origin main
```

---

# Running the App on the Server

## Step 1: Go to the Repository Directory

```bash
cd /home/ubuntu/dhg503-project
git remote add origin git@localhost:/home/git/repos/dhg503-project.git
```

> If the directory doesn't exist, complete the setup steps first.

## Step 2: Start the App

```bash
git pull
docker compose down --rmi all
docker compose up --build -d
```

## Security Considerations

**Note:** While this application prioritizes ease of use for educational purposes, in a production environment, you would need to implement:

- Secure credential storage (not plain text)
- SSH key passphrase protection
- Proper access control for the git user
- HTTPS for frontend-backend communication
- Input validation and sanitization

## Development Instructions

### Quick Start (Recommended)

The easiest way to build and run the application is to use the included shell script:

```bash
# Make the script executable if needed
chmod +x build-run.sh

# Run the script
./build-run.sh
```

This script will:

1. Check prerequisites (Python, Node.js, etc.)
2. Set up a Python virtual environment (.venv)
3. Install backend dependencies using pip or uv (if available)
4. Install frontend dependencies with yarn
5. Start the Create React App development server
6. Create necessary config files
7. Start the backend server using the virtual environment

### Frontend Build

```bash
cd frontend
yarn install             # Install dependencies
yarn dev               # Start development server
yarn build           # Build for production (generates the build/ folder)
```

The frontend is built using Create React App with TypeScript for type safety and better developer experience.

### Backend Setup

#### Using uv (recommended)

```bash
# Install uv if not already installed
pip install uv

# Create virtual environment
uv venv .venv

# Activate virtual environment
source .venv/bin/activate  # On Linux/macOS
.venv\Scripts\activate     # On Windows

# Install dependencies
cd backend
uv pip install -r requirements.txt

# Run the server
python main.py
```

#### Using pip

```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
source .venv/bin/activate  # On Linux/macOS
.venv\Scripts\activate     # On Windows

# Install dependencies
cd backend
pip install -r requirements.txt

# Run the server
python main.py
```

### Deployment

1. Build the React frontend with Vite
2. Start the Python backend server
3. Frontend will run on http://localhost:80
4. Backend will run on http://localhost:8888
