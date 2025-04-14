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

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 is not installed. Please install Python 3.8 or later.${NC}"
    exit 1
fi

# Function to install uv based on OS
install_uv() {
    echo -e "${YELLOW}uv not found. Would you like to install it? (y/n)${NC}"
    read -r install_choice
    
    if [[ $install_choice != "y" && $install_choice != "Y" ]]; then
        echo -e "${YELLOW}Skipping uv installation.${NC}"
        return
    fi
    
    echo -e "${BLUE}Installing uv package manager...${NC}"
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo -e "${BLUE}Detected macOS. Installing uv...${NC}"
        curl -LsSf https://astral.sh/uv/install.sh | sh
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo -e "${BLUE}Detected Linux. Installing uv...${NC}"
        curl -LsSf https://astral.sh/uv/install.sh | sh
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
        # Windows (Git Bash, MinGW, Cygwin)
        echo -e "${BLUE}Detected Windows. Installing uv...${NC}"
        powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
    else
        echo -e "${RED}Unsupported OS: $OSTYPE. Please install uv manually.${NC}"
        return 1
    fi
    
    echo -e "${GREEN}uv installation completed.${NC}"
    echo -e "${YELLOW}Please restart this script for the changes to take effect.${NC}"
    exit 0
}

# Check if pip or uv is installed
USE_UV=false
if command -v uv &> /dev/null; then
    echo -e "${GREEN}uv package manager found. Will use uv for dependency management.${NC}"
    USE_UV=true
elif command -v pip3 &> /dev/null; then
    echo -e "${YELLOW}pip3 found but uv is recommended for better performance.${NC}"
    install_uv
else
    echo -e "${RED}Neither pip3 nor uv is installed.${NC}"
    install_uv
    if [ $? -ne 0 ]; then
        echo -e "${RED}Please install pip or uv manually.${NC}"
        exit 1
    fi
fi

# Step 1: Set up virtual environment and install backend dependencies
echo -e "\n${GREEN}Step 1: Setting up virtual environment and installing backend dependencies...${NC}"
# No need to cd backend, requirements-server.txt is now in the root

# Create and activate virtual environment
if [ ! -d ".venv" ]; then
    echo -e "${BLUE}Creating virtual environment in .venv directory...${NC}"
    if [ "$USE_UV" = true ]; then
        uv venv .venv
    else
        python3 -m venv .venv
    fi
fi

# Activate virtual environment (platform-specific)
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    source .venv/bin/activate
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    source .venv/Scripts/activate
else
    echo -e "${YELLOW}Unknown OS type. Attempting standard activation...${NC}"
    source .venv/bin/activate
fi

# Install dependencies from root requirements-server.txt
if [ "$USE_UV" = true ]; then
    echo -e "${BLUE}Installing dependencies using uv...${NC}"
    uv pip install -r requirements-server.txt
else
    echo -e "${BLUE}Installing dependencies using pip...${NC}"
    pip3 install -r requirements-server.txt
fi

# No need for cd ..

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
    echo -e "${BLUE}Serving files from $(pwd) on port 80 in the background...${NC}"
    if [ -f "../../../.venv/bin/python" ]; then
        nohup ../../../.venv/bin/python -m http.server 80 &> frontend_server.log &
    elif [ -f "../../../.venv/Scripts/python.exe" ]; then
        # Running background tasks in Git Bash/MinGW on Windows can be tricky.
        # Using start /B for a non-console background process.
        start /B ../../../.venv/Scripts/python.exe -m http.server 80 &> frontend_server.log
    else
        echo -e "${YELLOW}Virtual environment python not found, attempting with system python...${NC}"
        nohup python3 -m http.server 80 &> frontend_server.log &
    fi
    FRONTEND_PID=$!
    echo -e "${GREEN}Frontend server started in background (PID: $FRONTEND_PID). Log: server-setting/frontend/dist/frontend_server.log${NC}"
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
# Execute main.py from the server-setting/backend directory using the venv python

# Make sure we're still using the virtual environment
if [ -f ".venv/bin/python" ]; then
    .venv/bin/python server-setting/backend/main.py
elif [ -f ".venv/Scripts/python.exe" ]; then
    .venv/Scripts/python.exe server-setting/backend/main.py
else
    echo -e "${YELLOW}Virtual environment python not found, using system python to run server-setting/backend/main.py...${NC}"
    python3 server-setting/backend/main.py
fi 