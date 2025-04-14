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

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}pip3 is not installed.${NC}"
    echo -e "${YELLOW}Would you like to attempt automatic installation? (Requires sudo/admin privileges) (y/n)${NC}"
    read -r install_pip_choice

    if [[ $install_pip_choice != "y" && $install_pip_choice != "Y" ]]; then
        echo -e "${YELLOW}Skipping pip3 installation. Please install it manually.${NC}"
        echo -e "${YELLOW}You can usually install it with 'sudo apt update && sudo apt install python3-pip' on Debian/Ubuntu or 'brew install python3' on macOS.${NC}"
        exit 1
    fi

    echo -e "${BLUE}Attempting to install pip3...${NC}"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Try to detect Debian/Ubuntu based systems
        if [ -f /etc/debian_version ] || grep -qi "debian" /etc/os-release || grep -qi "ubuntu" /etc/os-release; then
            echo -e "${BLUE}Detected Debian/Ubuntu based system. Running: sudo apt update && sudo apt install python3-pip${NC}"
            sudo apt update && sudo apt install -y python3-pip
            if [ $? -eq 0 ]; then
                 echo -e "${GREEN}pip3 installation command executed successfully.${NC}"
                 echo -e "${YELLOW}Please re-run this script.${NC}"
                 exit 0
            else
                 echo -e "${RED}pip3 installation failed. Please install it manually.${NC}"
                 exit 1
            fi
        else
            echo -e "${YELLOW}Detected Linux, but not Debian/Ubuntu. Cannot automatically install pip3.${NC}"
            echo -e "${YELLOW}Please install pip3 using your distribution's package manager.${NC}"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
             echo -e "${BLUE}Detected macOS with Homebrew. Running: brew install python3${NC}"
             # brew install python3 often includes pip3
             brew install python3
             if [ $? -eq 0 ]; then
                 echo -e "${GREEN}Homebrew command executed. This should install/update python3 and pip3.${NC}"
                 echo -e "${YELLOW}Please re-run this script.${NC}"
                 exit 0
             else
                 echo -e "${RED}Homebrew command failed. Please install python3/pip3 manually.${NC}"
                 exit 1
             fi
        else
             echo -e "${RED}Detected macOS, but Homebrew is not installed.${NC}"
             echo -e "${YELLOW}Please install Homebrew (https://brew.sh/) and then run 'brew install python3', or install Python 3 manually.${NC}"
             exit 1
        fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
        # Windows (Git Bash, MinGW, Cygwin)
        echo -e "${BLUE}Detected Windows environment.${NC}"
        echo -e "${YELLOW}Automatic pip installation is not supported on Windows via this script.${NC}"
        echo -e "${YELLOW}Please download and install Python 3 from the official website: https://www.python.org/downloads/${NC}"
        echo -e "${YELLOW}During installation, ensure you check the option 'Add Python to PATH' and that 'pip' is included.${NC}"
        echo -e "${YELLOW}After installation, please close this terminal, open a new one, and re-run the script.${NC}"
        exit 1
    else
        echo -e "${RED}Unsupported OS ($OSTYPE) for automatic pip3 installation.${NC}"
        echo -e "${YELLOW}Please install pip3 manually.${NC}"
        exit 1
    fi
fi

# Step 1: Set up virtual environment and install backend dependencies
echo -e "\n${GREEN}Step 1: Setting up virtual environment and installing backend dependencies...${NC}"

# Create and activate virtual environment
if [ ! -d ".venv" ]; then
    echo -e "${BLUE}Creating virtual environment in .venv directory using python3 -m venv...${NC}"
    python3 -m venv .venv
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to create virtual environment.${NC}"
        exit 1
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

# Install dependencies from root requirements-server.txt using pip
echo -e "${BLUE}Installing dependencies using pip...${NC}"
pip3 install -r requirements-server.txt
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to install dependencies from requirements-server.txt.${NC}"
    exit 1
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
    echo -e "${BLUE}Serving files from $(pwd) on port 80 in the background...${NC}"
    # Use python from the virtual environment
    VENV_PYTHON=""
    if [ -f "../../../.venv/bin/python" ]; then
        VENV_PYTHON="../../../.venv/bin/python"
    elif [ -f "../../../.venv/Scripts/python.exe" ]; then
        VENV_PYTHON="../../../.venv/Scripts/python.exe"
    fi

    if [ -n "$VENV_PYTHON" ]; then
        echo -e "${BLUE}Using virtual environment python: $VENV_PYTHON${NC}"
        if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
            # Running background tasks in Git Bash/MinGW on Windows can be tricky.
            # Using start /B for a non-console background process.
             start /B "$VENV_PYTHON" -m http.server 80 &> frontend_server.log
        else
             nohup "$VENV_PYTHON" -m http.server 80 &> frontend_server.log &
        fi
    else
        echo -e "${YELLOW}Virtual environment python not found, attempting with system python3...${NC}"
        if ! command -v python3 &> /dev/null; then
             echo -e "${RED}System python3 not found. Cannot start frontend server.${NC}"
             cd ../../.. # Go back to project root
             exit 1
        fi
         if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
             start /B python3 -m http.server 80 &> frontend_server.log
         else
             nohup python3 -m http.server 80 &> frontend_server.log &
         fi
    fi

    FRONTEND_PID=$! # Note: Getting PID might be unreliable with 'start /B' on Windows
    echo -e "${GREEN}Frontend server started in background (PID: $FRONTEND_PID might be inaccurate on Windows). Log: server-setting/frontend/dist/frontend_server.log${NC}"
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

# Ensure we use the virtual environment's python
VENV_PYTHON_EXEC=""
if [ -f ".venv/bin/python" ]; then
    VENV_PYTHON_EXEC=".venv/bin/python"
elif [ -f ".venv/Scripts/python.exe" ]; then
    VENV_PYTHON_EXEC=".venv/Scripts/python.exe"
fi

if [ -n "$VENV_PYTHON_EXEC" ]; then
    "$VENV_PYTHON_EXEC" server-setting/backend/main.py
else
    echo -e "${YELLOW}Virtual environment python not found, attempting with system python3 to run server-setting/backend/main.py...${NC}"
     if ! command -v python3 &> /dev/null; then
         echo -e "${RED}System python3 not found. Cannot start backend server.${NC}"
         exit 1
     fi
    python3 server-setting/backend/main.py
fi

# Optional: Clean up background process on exit (may not work reliably across platforms)
# trap "echo 'Stopping frontend server...'; kill $FRONTEND_PID 2>/dev/null" EXIT 