#!/bin/bash

# Check if Python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Please install it before running the script."
    exit
fi

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

# Ask the user which version to run (CLI or UI)
echo "Select launch mode:"
echo "0) UI (default)"
echo "1) CLI"

# Adding a 3-second timer for the user to respond
read -t 1 -p "Enter 1 for CLI (or leave empty for UI): " MODE

# If the user entered nothing, set default value to 0 (UI)
MODE=${MODE:-0}

if [ "$MODE" == "1" ]; then
    echo "Launching CLI version..."
    python run_cli.py
elif [ "$MODE" == "0" ]; then
    echo "Launching UI version in 2 seconds..."
    sleep 1  # Adding a 3-second delay before launching UI
    python run_ui.py &  # Launch UI in the background
    echo "Opening UI in the default browser..."
    sleep 0.5  # Short delay before opening the browser
    # Open the UI in the default browser (for Linux) xdg-open http://127.0.0.1:50001
    open http://127.0.0.1:50001 # For macOS
    # For Windows use: start http://127.0.0.1:50001
else
    echo "Invalid choice. Please enter 0 or 1."
    exit 1
fi