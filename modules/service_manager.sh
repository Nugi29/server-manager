#!/bin/bash

serviceManager() {
    while true
    do
    clear
    echo
    echo "=========================================="
    echo "             SERVICE MANAGER"
    echo "=========================================="
    echo " [1] List Running Services"
    echo " [2] Check Service Status"
    echo " [3] Start a Service"
    echo " [4] Stop a Service"
    echo " [5] Restart a Service"
    echo " [0] Back to Main Menu"
    echo
    read -p "Choose an option: " svc_choice

    if [ "$svc_choice" = "1" ]; then
        echo
        echo "--- Running Services (Top 30) ---"
        systemctl list-units --type=service --state=running --no-pager --no-legend 2>/dev/null | head -n 30 || echo "systemctl not available"

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$svc_choice" = "2" ]; then
        echo
        read -p "Enter service name: " svc_name
        systemctl status "$svc_name" --no-pager 2>/dev/null || echo "Unable to check service: $svc_name"

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$svc_choice" = "3" ]; then
        echo
        read -p "Enter service name to start: " svc_name
        sudo systemctl start "$svc_name" && echo "Service '$svc_name' started successfully." || echo "Failed to start '$svc_name'."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$svc_choice" = "4" ]; then
        echo
        read -p "Enter service name to stop: " svc_name
        sudo systemctl stop "$svc_name" && echo "Service '$svc_name' stopped successfully." || echo "Failed to stop '$svc_name'."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$svc_choice" = "5" ]; then
        echo
        read -p "Enter service name to restart: " svc_name
        sudo systemctl restart "$svc_name" && echo "Service '$svc_name' restarted successfully." || echo "Failed to restart '$svc_name'."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$svc_choice" = "0" ]; then
        return 0
    else
        echo
        echo "Invalid service option."
        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    fi
    done
}
