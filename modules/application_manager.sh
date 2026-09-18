#!/bin/bash

applicationManager() {
    echo
    echo "=========================================="
    echo "          APPLICATION MANAGER"
    echo "=========================================="
    echo "1. Check Common Web Servers (Nginx/Apache/Caddy)"
    echo "2. Check Container Runtime (Docker/Podman)"
    echo "3. Check Databases (MySQL/PostgreSQL/Redis/MongoDB)"
    echo "4. Check Installed Runtimes (Node/Python/Go/Java)"
    echo "0. Back to Main Menu"
    echo
    read -p "Choose an option: " app_choice

    if [ "$app_choice" = "1" ]; then
        echo
        echo "--- Web Server Status ---"
        for s in nginx apache2 httpd caddy; do
            if command -v "$s" >/dev/null 2>&1; then
                echo "$s is installed ($(systemctl is-active "$s" 2>/dev/null || echo "inactive"))"
            fi
        done
    elif [ "$app_choice" = "2" ]; then
        echo
        echo "--- Container Status ---"
        if command -v docker >/dev/null 2>&1; then
            docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || echo "Docker daemon not running or requires sudo."
        else
            echo "Docker not installed."
        fi
    elif [ "$app_choice" = "3" ]; then
        echo
        echo "--- Database Status ---"
        for db in mysql mysqld mariadb postgresql redis redis-server mongod; do
            if systemctl list-unit-files "$db.service" 2>/dev/null | grep -q "$db"; then
                echo "$db service: $(systemctl is-active "$db" 2>/dev/null)"
            fi
        done
    elif [ "$app_choice" = "4" ]; then
        echo
        echo "--- Installed Runtimes ---"
        python3 --version 2>/dev/null || echo "Python 3: Not installed"
        node --version 2>/dev/null && echo "Node.js: $(node --version)" || echo "Node.js: Not installed"
        go version 2>/dev/null || echo "Go: Not installed"
        java -version 2>&1 | head -n 1 || echo "Java: Not installed"
    elif [ "$app_choice" = "0" ]; then
        return 0
    else
        echo "Invalid application option."
    fi
}
