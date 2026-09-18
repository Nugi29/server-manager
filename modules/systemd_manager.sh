#!/bin/bash

systemdManager() {
    while true
    do
    clear
    echo
    echo "=========================================="
    echo "             SYSTEMD MANAGER"
    echo "=========================================="
    echo " [1] List Failed Units"
    echo " [2] System Boot Performance (systemd-analyze)"
    echo " [3] List Active Timers"
    echo " [4] Reload Systemd Daemon (daemon-reload)"
    echo " [0] Back to Main Menu"
    echo
    read -p "Choose an option: " sd_choice

    if [ "$sd_choice" = "1" ]; then
        echo
        echo "--- Failed Systemd Units ---"
        systemctl --failed --no-pager 2>/dev/null || echo "systemctl command not available"

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$sd_choice" = "2" ]; then
        echo
        echo "--- Boot Analysis ---"
        systemd-analyze 2>/dev/null || echo "systemd-analyze not available"
        echo
        systemd-analyze blame 2>/dev/null | head -n 10 || true

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$sd_choice" = "3" ]; then
        echo
        echo "--- Active Timers ---"
        systemctl list-timers --no-pager 2>/dev/null || echo "systemctl timers not available"

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$sd_choice" = "4" ]; then
        echo "Reloading systemd daemon..."
        sudo systemctl daemon-reload && echo "Daemon reloaded successfully." || echo "Failed to reload daemon."

        echo
        read -p "Do you want to go Main Menu(Y/N): " op
        if [ "$op" = "Y" ] || [ "$op" = "y" ];
            then break;
        else
            continue;
        fi
    elif [ "$sd_choice" = "0" ]; then
        return 0
    else
        echo
        echo "Invalid systemd option."
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
