#!/bin/bash

serviceManager() {
    echo
    echo "=========================================="
    echo "             SERVICE MANAGER"
    echo "=========================================="
    echo "1. List Running Services"
    echo "2. Check Service Status"
    echo "3. Start a Service"
    echo "4. Stop a Service"
    echo "5. Restart a Service"
    echo "0. Back to Main Menu"
    echo
    read -p "Choose an option: " svc_choice

    if [ "$svc_choice" = "1" ]; then
        echo
        echo "--- Running Services (Top 30) ---"
        systemctl list-units --type=service --state=running --no-pager --no-legend 2>/dev/null | head -n 30 || echo "systemctl not available"
    elif [ "$svc_choice" = "2" ]; then
        read -p "Enter service name: " svc_name
        systemctl status "$svc_name" --no-pager 2>/dev/null || echo "Unable to check service: $svc_name"
    elif [ "$svc_choice" = "3" ]; then
        read -p "Enter service name to start: " svc_name
        sudo systemctl start "$svc_name" && echo "Service '$svc_name' started successfully." || echo "Failed to start '$svc_name'."
    elif [ "$svc_choice" = "4" ]; then
        read -p "Enter service name to stop: " svc_name
        sudo systemctl stop "$svc_name" && echo "Service '$svc_name' stopped successfully." || echo "Failed to stop '$svc_name'."
    elif [ "$svc_choice" = "5" ]; then
        read -p "Enter service name to restart: " svc_name
        sudo systemctl restart "$svc_name" && echo "Service '$svc_name' restarted successfully." || echo "Failed to restart '$svc_name'."
    elif [ "$svc_choice" = "0" ]; then
        return 0
    else
        echo "Invalid service option."
    fi
}
