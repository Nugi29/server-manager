#!/bin/bash

# ==========================================
# AWS Server Manager
# ==========================================

show_banner() {
    clear

    echo "=========================================="
    echo "          AWS SERVER MANAGER"
    echo "=========================================="
    echo
}

show_menu() {
    echo "1. Server Information"
    echo "2. Network Information"
    echo "3. Service Manager"
    echo "4. Systemd Manager"
    echo "5. Process Manager"
    echo "6. Log Manager"
    echo "7. Resource Monitor"
    echo "8. Application Manager"
    echo "9. Security"
    echo "10. Maintenance"
    echo "0. Exit"
    echo
}

server_information() {
    echo
    echo "========== SERVER INFORMATION =========="
    echo
    echo "Hostname : $(hostname)"
    echo "Kernel   : $(uname -r)"
    echo "OS       : $(uname -s)"
    echo "Uptime   : $(uptime -p)"
    echo
}

while true
do
    show_banner
    show_menu

    read -p "Enter your choice: " choice

    case $choice in

        1)
            server_information
            read -p "Press Enter to continue..."
            ;;

        0)
            echo
            echo "Goodbye!"
            exit 0
            ;;

        *)
            echo
            echo "Invalid option!"
            read -p "Press Enter to continue..."
            ;;

    esac
done