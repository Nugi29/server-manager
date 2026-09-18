#!/bin/bash

maintenance() {
    while true
    do
    clear
    echo
    echo "=========================================="
    echo "          SYSTEM MAINTENANCE"
    echo "=========================================="
    echo " [1] Check for Package Updates"
    echo " [2] Clean Package Cache & Orphaned Packages"
    echo " [3] Clean System Temporary Files (/tmp)"
    echo " [4] Clear PageCache, Dentries and Inodes (Drop Caches)"
    echo " [0] Back to Main Menu"
    echo
    read -p "Choose an option: " maint_choice

    if [ "$maint_choice" = "1" ]; then
        echo
        echo "--- Checking Updates ---"
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt list --upgradable
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf check-update
        elif command -v yum >/dev/null 2>&1; then
            sudo yum check-update
        else
            echo "No supported package manager found."
        fi

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$maint_choice" = "2" ]; then
        echo
        echo "--- Cleaning Package Cache ---"
        if command -v apt >/dev/null 2>&1; then
            sudo apt autoremove -y && sudo apt clean
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf autoremove -y && sudo dnf clean all
        elif command -v yum >/dev/null 2>&1; then
            sudo yum autoremove -y && sudo yum clean all
        fi
        echo "Package cache cleaned."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$maint_choice" = "3" ]; then
        echo "Cleaning /tmp directory..."
        sudo find /tmp -type f -atime +7 -delete 2>/dev/null || true
        echo "Old temporary files removed."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$maint_choice" = "4" ]; then
        echo "Syncing filesystem and freeing page cache..."
        sync && echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1 && echo "Memory cache cleared." || echo "Requires root/sudo privileges."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$maint_choice" = "0" ]; then
        return 0
    else
        echo
        echo "Invalid maintenance option."
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
