#!/bin/bash

# Function to kill processes for run_ui.py and run_cli.py
kill_processes() {
    echo "Stopping any running processes for run_ui.py and run_cli.py..."
    pkill -f run_ui.py  # Kill all processes related to run_ui.py
    pkill -f run_cli.py  # Kill all processes related to run_cli.py
    echo "Processes stopped."
}



# Function for installing requirements
install_requirements() {
    echo "Installing required packages..."

    # Check Python version
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    REQUIRED_VERSION="3.11"

    if [[ "$PYTHON_VERSION" != $REQUIRED_VERSION* ]]; then
        echo "Current Python version ($PYTHON_VERSION) does not meet the requirement ($REQUIRED_VERSION)."
        exit 1
    else
        echo "Python $REQUIRED_VERSION is already installed."
    fi

    # Check and create a virtual environment (venv) if it doesn't exist
    if [ ! -d "venv" ]; then
        echo "Creating a new virtual environment 'venv'..."
        python3 -m venv venv
        echo "Virtual environment created."
    else
        echo "Virtual environment 'venv' already exists."
    fi

    # Activate venv
    echo "Activating the virtual environment..."
    source venv/bin/activate

    # Check and install/upgrade pip, setuptools, and dependencies
    echo "Checking installed packages..."
    pip install --upgrade pip \
     && pip install --upgrade setuptools \
     && pip install -r requirements.txt
    echo "Requirements installed."
}

 # Check if Python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Please choose 3) Install requirements."
    exit
fi

# Activate venv
echo "Activating the virtual environment..."
source venv/bin/activate

# Ask the user which version to run
echo "Select launch mode:"
echo "0) UI"
echo "1) CLI"
echo "2) Stop all running processes"
echo "3) Install requirements"

# Adding a 3-second timer for the user to respond
read -t 5 -p "Enter 0-4 (or leave empty for default UI): " MODE

# If the user entered nothing, set default value to 0 (UI)
MODE=${MODE:-0}

if [ "$MODE" == "1" ]; then
    echo "Launching CLI version..."
    python run_cli.py

elif [ "$MODE" == "0" ]; then
    echo "Launching UI version in 2 seconds..."
    python run_ui.py &  # Launch UI in the background
    open http://127.0.0.1:50001  # For macOS
    # For Linux: xdg-open http://127.0.0.1:50001
    # For Windows: start http://127.0.0.1:50001

elif [ "$MODE" == "2" ]; then
    kill_processes  # Kill all related processes

elif [ "$MODE" == "3" ]; then
    echo "Running installation of requirements..."
    install_requirements  # Run the installation of requirements

else
    echo "Invalid choice. Please enter 0-3."
    exit 1
fi