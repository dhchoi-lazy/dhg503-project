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
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    # Check if 'python' is Python 3
    py_version=$("python" -V 2>&1)
    if [[ $py_version == "Python 3"* ]]; then
        PYTHON_CMD="python"
    fi
fi

if [ -z "$PYTHON_CMD" ]; then
    echo -e "${RED}Python 3 is not found on PATH (checked 'python3' and 'python').${NC}"
    echo -e "${YELLOW}Please install Python 3.8 or later and ensure it is added to your PATH.${NC}"
    echo -e "${YELLOW}Download from: https://www.python.org/downloads/${NC}"
    exit 1
else
     echo -e "${GREEN}Using Python command: $PYTHON_CMD${NC}"
     # Optional: Add a version check here if needed
     # "$PYTHON_CMD" -c "import sys; sys.exit(not (sys.version_info >= (3, 8)))"
     # if [ $? -ne 0 ]; then ... exit ... fi
fi

# Step 1: Set up virtual environment and install backend dependencies
echo -e "\n${GREEN}Step 1: Setting up virtual environment and installing backend dependencies...${NC}"

# Create and activate virtual environment
if [ ! -d ".venv" ]; then
    echo -e "${BLUE}Creating virtual environment in .venv directory using '$PYTHON_CMD -m venv'...${NC}"
    venv_error_log="venv_creation_error.log"
    # Use --clear to ensure a clean environment if .venv exists but is broken
    "$PYTHON_CMD" -m venv .venv --clear 2> "$venv_error_log" 
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

        if $is_debian_ubuntu && echo "$error_output" | grep -q "ensurepip is not available"; then
            suggested_package=$(echo "$error_output" | grep -o 'python3\\.[0-9]*-venv' | head -n 1)
            if [ -z "$suggested_package" ]; then
                suggested_package="python3-venv"
            fi
            echo -e "${YELLOW}This failure often means the '$suggested_package' package is missing.${NC}"
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
        # Add specific hint for Windows alias issue
        if $is_windows && echo "$error_output" | grep -q "Python was not found"; then
            echo -e "${YELLOW}Hint: On Windows, this error often occurs if the 'python' or 'python3' command executes the Microsoft Store alias instead of a full Python installation.${NC}"
            echo -e "${YELLOW}Please ensure a full Python 3 installation (from python.org or elsewhere) is available and prioritized in your PATH, or disable the 'App execution aliases' for Python in Windows Settings.${NC}"
        fi
        echo -e "${RED}Virtual environment creation error details:${NC}"
        echo "$error_output"
        rm -f "$venv_error_log"
        exit 1
    fi
    rm -f "$venv_error_log"
    echo -e "${GREEN}Virtual environment created successfully.${NC}"
fi

# Activate virtual environment (platform-specific)
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    VENV_PYTHON=".venv/bin/python"
    VENV_ACTIVATE=".venv/bin/activate"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    VENV_PYTHON=".venv/Scripts/python.exe"
    VENV_ACTIVATE=".venv/Scripts/activate"
else
    echo -e "${YELLOW}Unknown OS type ($OSTYPE). Attempting standard activation...${NC}"
    VENV_PYTHON=".venv/bin/python"
    VENV_ACTIVATE=".venv/bin/activate"
fi

echo -e "${BLUE}Activating virtual environment: source $VENV_ACTIVATE${NC}"
if [ -f "$VENV_ACTIVATE" ]; then
    source "$VENV_ACTIVATE"
else
    echo -e "${RED}Virtual environment activation script not found: $VENV_ACTIVATE${NC}"
    echo -e "${RED}Cannot proceed without activating the virtual environment.${NC}"
    exit 1
fi

# Install dependencies using the virtual environment's python/pip
echo -e "${BLUE}Attempting to install dependencies using 'python -m pip' from virtual environment...${NC}"
python -m pip install --upgrade pip # Ensure pip is up-to-date within venv
python -m pip install -r requirements-server.txt
pip_exit_code=$?

# Check final status
if [ $pip_exit_code -ne 0 ]; then
    echo -e "${RED}Failed to install dependencies from requirements-server.txt using 'python -m pip' (Exit code: $pip_exit_code).${NC}"
    echo -e "${RED}Please check requirements-server.txt and network connection.${NC}"
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
    echo -e "${BLUE}Serving files from $(pwd) on port 80 in the background using venv python...${NC}"

    # Use python from the virtual environment (path relative to dist dir)
    VENV_PYTHON_REL="../../../$VENV_PYTHON"

    if [ -f "$VENV_PYTHON_REL" ]; then
        echo -e "${BLUE}Using virtual environment python: $VENV_PYTHON_REL${NC}"
        if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
             start /B "" "$VENV_PYTHON_REL" -m http.server 80 &> frontend_server.log
        else
             nohup "$VENV_PYTHON_REL" -m http.server 80 &> frontend_server.log &
        fi
        FRONTEND_PID=$! # Note: Getting PID might be unreliable with 'start /B' on Windows
        echo -e "${GREEN}Frontend server started in background (PID: $FRONTEND_PID might be inaccurate on Windows). Log: $(pwd)/frontend_server.log${NC}"
    else
        echo -e "${RED}Virtual environment python not found at expected path: $VENV_PYTHON_REL${NC}"
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