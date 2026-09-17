#!/bin/bash

resourceMonitor() {
    echo
    echo "=========================================="
    echo "            RESOURCE MONITOR"
    echo "=========================================="
    echo "Load Average  : $(uptime 2>/dev/null | awk -F'load average:' '{print $2}' || cat /proc/loadavg 2>/dev/null || echo "N/A")"
    echo
    echo "--- CPU Usage ---"
    if command -v mpstat >/dev/null 2>&1; then
        mpstat 1 1 2>/dev/null
    elif command -v top >/dev/null 2>&1; then
        top -bn1 2>/dev/null | head -n 5
    else
        echo "CPU stats unavailable"
    fi
    echo
    echo "--- Memory Usage ---"
    free -h 2>/dev/null || echo "free command not available"
    echo
    echo "--- Disk Usage by Filesystem ---"
    df -h -x tmpfs -x devtmpfs 2>/dev/null || df -h 2>/dev/null || echo "df command not available"
    echo
}
