#!/bin/bash

showBanner() {
    clear
    echo "=========================================="
    echo "          SERVER MANAGER"
    echo "=========================================="
    echo
}

showMenu() {
    echo " 1. Server Information"
    echo " 2. Network Information"
    echo " 3. Service Manager"
    echo " 4. Systemd Manager"
    echo " 5. Process Manager"
    echo " 6. Log Manager"
    echo " 7. Resource Monitor"
    echo " 8. Application Manager"
    echo " 9. Security"
    echo "10. Maintenance"
    echo " 0. Exit"
    echo
}
