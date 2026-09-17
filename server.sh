#!/bin/bash

# Base directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all component modules
for module in "$SCRIPT_DIR"/modules/*.sh; do
    if [ -f "$module" ]; then
        # shellcheck disable=SC1090
        source "$module"
    fi
done

# Main Execution Loop
while true
do
    showBanner
    showMenu

    read -p "Enter your choice: " choice

    if [ "$choice" = "1" ]; then
        serverInformation
        read -p "Press Enter to continue..."
    elif [ "$choice" = "2" ]; then
        networkInformation
        read -p "Press Enter to continue..."
    elif [ "$choice" = "3" ]; then
        serviceManager
        read -p "Press Enter to continue..."
    elif [ "$choice" = "4" ]; then
        systemdManager
        read -p "Press Enter to continue..."
    elif [ "$choice" = "5" ]; then
        processManager
        read -p "Press Enter to continue..."
    elif [ "$choice" = "6" ]; then
        logManager
        read -p "Press Enter to continue..."
    elif [ "$choice" = "7" ]; then
        resourceMonitor
        read -p "Press Enter to continue..."
    elif [ "$choice" = "8" ]; then
        applicationManager
        read -p "Press Enter to continue..."
    elif [ "$choice" = "9" ]; then
        security
        read -p "Press Enter to continue..."
    elif [ "$choice" = "10" ]; then
        maintenance
        read -p "Press Enter to continue..."
    elif [ "$choice" = "0" ]; then
        echo
        echo "Goodbye!"
        exit 0
    else
        echo
        echo "Invalid option!"
        read -p "Press Enter to continue..."
    fi
done