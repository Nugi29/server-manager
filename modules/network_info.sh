#!/bin/bash

networkInformation() {
    echo
    echo "=========================================="
    echo "         NETWORK INFORMATION"
    echo "=========================================="
    echo "Hostname      : $(hostname 2>/dev/null || echo "N/A")"
    echo "Local IP(s)   : $(hostname -I 2>/dev/null || ip -4 addr show 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | tr '\n' ' ' || echo "N/A")"
    echo "Public IP     : $(curl -s --connect-timeout 2 ifconfig.me 2>/dev/null || echo "Unavailable/Offline")"
    echo "Gateway       : $(ip route 2>/dev/null | grep default | awk '{print $3}' || echo "N/A")"
    echo "DNS Servers   : $(grep "nameserver" /etc/resolv.conf 2>/dev/null | awk '{print $2}' | tr '\n' ' ' || echo "N/A")"
    echo
    echo "Network Interfaces:"
    ip -br addr show 2>/dev/null || ifconfig 2>/dev/null || echo "ip/ifconfig command not available"
    echo
    echo "Active Listening Ports (TCP/UDP):"
    ss -tuln 2>/dev/null || netstat -tuln 2>/dev/null || echo "ss/netstat command not available"
    echo
}
