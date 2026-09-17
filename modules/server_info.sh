#!/bin/bash

serverInformation() {
    echo
    echo "=========================================="
    echo "          SERVER INFORMATION"
    echo "=========================================="
    echo "Hostname      : $(hostname 2>/dev/null || echo "N/A")"
    echo "Kernel        : $(uname -r 2>/dev/null || echo "N/A")"
    echo "Architecture  : $(uname -m 2>/dev/null || echo "N/A")"
    
    if [ -f /etc/os-release ]; then
        # shellcheck disable=SC1091
        source /etc/os-release
        echo "OS            : $PRETTY_NAME"
    else
        echo "OS            : $(uname -s 2>/dev/null || echo "N/A")"
    fi

    echo "Uptime        : $(uptime -p 2>/dev/null || uptime 2>/dev/null || echo "N/A")"
    echo "Current User  : $(whoami 2>/dev/null || echo "N/A")"
    echo "Date/Time     : $(date 2>/dev/null || echo "N/A")"
    echo "------------------------------------------"
    echo "CPU Model     : $(grep -m1 'model name' /proc/cpuinfo 2>/dev/null | cut -d: -f2 | xargs || lscpu 2>/dev/null | grep 'Model name' | cut -d: -f2 | xargs || echo "N/A")"
    echo "CPU Cores     : $(nproc 2>/dev/null || grep -c ^processor /proc/cpuinfo 2>/dev/null || echo "N/A")"
    echo
    echo "Memory Overview:"
    free -h 2>/dev/null || echo "free command not available"
    echo
    echo "Root Disk Usage:"
    df -h / 2>/dev/null || echo "df command not available"
    echo
}
