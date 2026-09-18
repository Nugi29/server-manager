#!/bin/bash

showBanner() {
    clear
    printf "\033[0;32m"
    echo "  __   ___   ___   _   _   ___   ___     __ __    __    __  _    __     __   ___   ___  "
    echo "/' _/ | __| | _ \\ | \\ / | | __| | _ \\   |  V  |  /  \\  |  \\| |  /  \\   / _] | __| | _ \\ "
    echo "\`._\`. | _|  | v / \`\\ V /' | _|  | v /   | \\_/ | | /\\ | | | ' | | /\\ | | [/\\ | _|  | v / "
    echo "|___/ |___| |_|_\\   \\_/   |___| |_|_\\   |_| |_| |_||_| |_|\\__| |_||_|  \\__/ |___| |_|_\\ "
    printf "\033[0m"
    echo
}

showMenu() {
    echo " [1] Server Information"
    echo " [2] Network Information"
    echo " [3] Service Manager"
    echo " [4] Systemd Manager"
    echo " [5] Process Manager"
    echo " [6] Log Manager"
    echo " [7] Resource Monitor"
    echo " [8] Application Manager"
    echo " [9] Security"
    echo "[10] Maintenance"
    echo " [0] Exit"
    echo
}
