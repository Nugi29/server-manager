#!/bin/bash

processManager() {
    echo
    echo "=========================================="
    echo "             PROCESS MANAGER"
    echo "=========================================="
    echo "1. Top 10 CPU Consuming Processes"
    echo "2. Top 10 Memory Consuming Processes"
    echo "3. Search Process by Name"
    echo "4. Kill a Process by PID"
    echo "0. Back to Main Menu"
    echo
    read -p "Choose an option: " proc_choice

    if [ "$proc_choice" = "1" ]; then
        echo
        echo "--- Top CPU Processes ---"
        ps aux --sort=-%cpu 2>/dev/null | head -n 11 || echo "ps command not available"
    elif [ "$proc_choice" = "2" ]; then
        echo
        echo "--- Top Memory Processes ---"
        ps aux --sort=-%mem 2>/dev/null | head -n 11 || echo "ps command not available"
    elif [ "$proc_choice" = "3" ]; then
        read -p "Enter process search term: " proc_name
        echo
        ps aux | grep -i "$proc_name" | grep -v "grep" || echo "No matching processes found."
    elif [ "$proc_choice" = "4" ]; then
        read -p "Enter PID to kill: " target_pid
        if [ -n "$target_pid" ]; then
            kill "$target_pid" 2>/dev/null && echo "Process $target_pid terminated." || echo "Failed to kill process $target_pid. (Check permissions / PID existence)"
        fi
    elif [ "$proc_choice" = "0" ]; then
        return 0
    else
        echo "Invalid process option."
    fi
}
