#!/bin/bash

security() {
    echo
    echo "=========================================="
    echo "            SECURITY OVERVIEW"
    echo "=========================================="
    echo "1. Currently Logged In Users"
    echo "2. Check Failed Login Attempts"
    echo "3. Firewall Status (UFW / Iptables / Firewalld)"
    echo "4. Sudoers / Admin Users"
    echo "5. Open Listening Ports & Associated Programs"
    echo "0. Back to Main Menu"
    echo
    read -p "Choose an option: " sec_choice

    if [ "$sec_choice" = "1" ]; then
        echo
        echo "--- Active Sessions ---"
        who 2>/dev/null || w 2>/dev/null || echo "who/w command not available"
    elif [ "$sec_choice" = "2" ]; then
        echo
        echo "--- Failed SSH / Login Attempts (Last 20) ---"
        journalctl _SYSTEMD_UNIT=ssh.service _SYSTEMD_UNIT=sshd.service 2>/dev/null | grep -i "failed" | tail -n 20 || lastb 2>/dev/null | head -n 20 || grep -i "failed" /var/log/auth.log 2>/dev/null | tail -n 20 || echo "No recent failed logins found or permission denied."
    elif [ "$sec_choice" = "3" ]; then
        echo
        echo "--- Firewall Status ---"
        if command -v ufw >/dev/null 2>&1; then
            sudo ufw status verbose 2>/dev/null || ufw status 2>/dev/null
        elif command -v firewall-cmd >/dev/null 2>&1; then
            firewall-cmd --state 2>/dev/null
        else
            sudo iptables -L -n -v 2>/dev/null | head -n 20 || echo "Firewall tools not accessible."
        fi
    elif [ "$sec_choice" = "4" ]; then
        echo
        echo "--- Sudo / Admin Group Members ---"
        getent group sudo 2>/dev/null || getent group wheel 2>/dev/null || getent group admin 2>/dev/null || echo "Unable to query admin groups."
    elif [ "$sec_choice" = "5" ]; then
        echo
        echo "--- Open Ports & Processes ---"
        sudo ss -tulnp 2>/dev/null || ss -tuln 2>/dev/null || echo "ss command not available"
    elif [ "$sec_choice" = "0" ]; then
        return 0
    else
        echo "Invalid security option."
    fi
}
