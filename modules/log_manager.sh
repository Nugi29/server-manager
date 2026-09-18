#!/bin/bash

logManager() {
    while true
    do
    clear
    echo
    echo "=========================================="
    echo "               LOG MANAGER"
    echo "=========================================="
    echo " [1] Recent System Logs (journalctl last 30 lines)"
    echo " [2] Kernel / Hardware Logs (dmesg warnings & errors)"
    echo " [3] Authentication / SSH Logs"
    echo " [4] View Specific Service Log"
    echo " [0] Back to Main Menu"
    echo
    read -p "Choose an option: " log_choice

    if [ "$log_choice" = "1" ]; then
        echo
        echo "--- Recent Journalctl Logs ---"
        journalctl -n 30 --no-pager 2>/dev/null || tail -n 30 /var/log/syslog 2>/dev/null || tail -n 30 /var/log/messages 2>/dev/null || echo "Unable to read system logs."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$log_choice" = "2" ]; then
        echo
        echo "--- Kernel Errors & Warnings ---"
        dmesg --level=err,warn 2>/dev/null | tail -n 30 || dmesg 2>/dev/null | tail -n 30 || echo "dmesg not available"

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$log_choice" = "3" ]; then
        echo
        echo "--- Auth / SSH Logs ---"
        journalctl -u ssh -u sshd -n 30 --no-pager 2>/dev/null || tail -n 30 /var/log/auth.log 2>/dev/null || tail -n 30 /var/log/secure 2>/dev/null || echo "Unable to read auth logs."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$log_choice" = "4" ]; then
        read -p "Enter service name (e.g., nginx, docker): " svc_log_name
        echo
        journalctl -u "$svc_log_name" -n 30 --no-pager 2>/dev/null || echo "Unable to retrieve logs for $svc_log_name."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$log_choice" = "0" ]; then
        return 0
    else
        echo
        echo "Invalid log option."
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
