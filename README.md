# 🖥️ Server Manager CLI — Bash Learning Project

A modular, interactive CLI tool for Linux system administration, monitoring, diagnostics, and maintenance. This project was built as a comprehensive hands-on exercise to learn and master **Bash scripting**, **Linux internals**, and **shell automation**.

---

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Key Features](#-key-features)
- [Project Architecture](#-project-architecture)
- [Getting Started](#-getting-started)
- [Core Learning Outcomes](#-core-learning-outcomes)
- [Comprehensive Bash Syntax & Command Reference](#-comprehensive-bash-syntax--command-reference)
  - [1. Control Flow & Looping Constructs](#1-control-flow--looping-constructs)
  - [2. Variables, Expansions & Quoting](#2-variables-expansions--quoting)
  - [3. Operators & Conditionals](#3-operators--conditionals)
  - [4. Streams, Pipes & Redirections](#4-streams-pipes--redirections)
  - [5. Bash Builtins & Keywords](#5-bash-builtins--keywords)
  - [6. Linux System & Diagnostic Utilities](#6-linux-system--diagnostic-utilities)
  - [7. Text Processing & Stream Transformation](#7-text-processing--stream-transformation)
- [Best Practices Applied](#-best-practices-applied)
- [License](#-license)

---

## 🚀 Project Overview

The **Server Manager CLI** provides a terminal dashboard with 10 dedicated sub-modules to manage and monitor a Linux server without memorizing dozens of complex flags and commands.

### ✨ Highlights
- **100% Native Bash**: Written without heavy third-party framework dependencies.
- **Dynamic Module Loading**: Automatically detects and sources all module scripts in `modules/`.
- **Defensive & Portable**: Gracefully checks for tool availability across Debian/Ubuntu, RHEL/CentOS/Fedora, and fallback environments.
- **ANSI Styling & UI**: Clean terminal layout with ASCII banners, formatted color output, and interactive loops.

---

## 🛠 Key Features

| # | Module | Description | Key Tools Used |
|---|---|---|---|
| **1** | **Server Information** | Hostname, Kernel, OS, Uptime, CPU specs, RAM, and root disk usage. | `uname`, `/proc/cpuinfo`, `free`, `df` |
| **2** | **Network Information** | Local & public IPs, gateway, DNS servers, interfaces, and active ports. | `ip`, `ss`, `curl`, `/etc/resolv.conf` |
| **3** | **Service Manager** | List running services, check status, start, stop, and restart services. | `systemctl`, `sudo` |
| **4** | **Systemd Manager** | List failed units, boot time analysis (`systemd-analyze blame`), and timers. | `systemd-analyze`, `systemctl` |
| **5** | **Process Manager** | Top CPU/memory consumers, process search, and PID termination. | `ps aux`, `grep`, `kill` |
| **6** | **Log Manager** | System logs, dmesg errors/warnings, SSH auth logs, and service logs. | `journalctl`, `dmesg`, `tail` |
| **7** | **Resource Monitor** | Load averages, live CPU usage, memory consumption, and disk partitions. | `uptime`, `mpstat`, `top`, `free` |
| **8** | **Application Manager** | Status of web servers (Nginx, Apache), Docker, databases, and language runtimes. | `docker`, `python3`, `node`, `go` |
| **9** | **Security Overview** | Active user sessions, failed login attempts, firewall status, and sudoers. | `who`, `lastb`, `ufw`, `getent` |
| **10** | **Maintenance** | Package updates, cache cleaning, `/tmp` file purging, and dropping caches. | `apt`, `dnf`, `find`, `sync` |

---

## 📂 Project Architecture

```plaintext
server-test/
├── server.sh                     # Main entry point & dispatch loop
├── README.md                     # Documentation & Bash cheat sheet
└── modules/                      # Feature modules sourced dynamically
    ├── ui.sh                     # ASCII banner and menu UI
    ├── server_info.sh            # Server information module
    ├── network_info.sh           # Network diagnostics module
    ├── service_manager.sh        # Systemd service manager
    ├── systemd_manager.sh        # Systemd health & boot analysis
    ├── process_manager.sh        # Process monitoring & signals
    ├── log_manager.sh            # System, kernel & auth log viewer
    ├── resource_monitor.sh       # CPU, memory, and disk monitor
    ├── application_manager.sh    # Web, DB, container & runtime detector
    ├── security.sh               # Security audits, logins, and firewalls
    └── maintenance.sh            # System cleanup & cache drop utilities
```

---

## ⚡ Getting Started

### Prerequisites
- Any Linux distribution (Ubuntu/Debian, Fedora/RHEL, Arch, etc.) or WSL2 on Windows.
- `bash` (version 4.0+ recommended).
- `sudo` access for administrative modules (service control, firewall checks, cache purge).

### Installation & Run

```bash
# Clone the repository
git clone https://github.com/your-username/server-manager-bash.git
cd server-manager-bash

# Ensure scripts have execute permissions
chmod +x server.sh modules/*.sh

# Run the manager
./server.sh
# or
bash server.sh
```

---

## 🎯 Core Learning Outcomes

Through building this project, the following core Bash scripting concepts and Linux systems skills were practiced and mastered:

1. **Modular Script Architecture**:
   - Splitting monolithic scripts into reusable module files under `modules/`.
   - Resolving dynamic file paths reliably with `dirname` and `BASH_SOURCE`.
   - Sourcing code dynamically with `source "$module"`.

2. **Interactive CLI & User Experience (UX)**:
   - Infinite interactive menu loops with `while true` and clean exit conditions (`break`, `exit`, `return`).
   - User prompt capture using `read -p` with input validation.
   - ANSI escape sequences for terminal colors (`\033[0;32m` and `\033[0m`) and screen clearing (`clear`).

3. **Defensive & Fault-Tolerant Scripting**:
   - Redirecting standard error to `/dev/null` (`2>/dev/null`) to suppress noisy permission errors.
   - Employing short-circuit fallback chains (`command1 || command2 || echo "N/A"`).
   - Checking tool availability across different Linux distributions using `command -v`.

4. **Linux Internals & `/proc` Filesystem Exploration**:
   - Reading virtual filesystems for CPU specs (`/proc/cpuinfo`), load averages (`/proc/loadavg`), and kernel cache triggers (`/proc/sys/vm/drop_caches`).
   - Parsing system configuration files like `/etc/os-release` and `/etc/resolv.conf`.

5. **Advanced Text Processing & Pipelines**:
   - Chaining commands via standard Unix pipes (`|`).
   - Extracting structured data using `grep`, `cut`, `awk`, `tr`, `sed`, `xargs`, `head`, and `tail`.
   - Leveraging Perl-compatible regular expressions (`grep -oP`).

---

## 📖 Comprehensive Bash Syntax & Command Reference

### 1. Control Flow & Looping Constructs

#### Infinite Interactive Loops (`while true`)
Keeps submenus active until the user decides to return to the main menu.
```bash
while true; do
    # Display menu and read input
    read -p "Choose an option: " choice
    if [ "$choice" = "0" ]; then
        return 0  # Exit function and return to caller
    fi
done
```

#### Globbing & Sourcing Loop (`for ... in`)
Dynamically iterates over matching files and imports their functions.
```bash
for module in "$SCRIPT_DIR"/modules/*.sh; do
    if [ -f "$module" ]; then
        source "$module"
    fi
done
```

#### Conditional Branching (`if`, `elif`, `else`, `fi`)
```bash
if [ "$op" = "Y" ] || [ "$op" = "y" ]; then
    break
else
    continue
fi
```

---

### 2. Variables, Expansions & Quoting

| Syntax | Description | Project Example |
|---|---|---|
| `$(command)` | **Command Substitution**: Executes `command` in a subshell and substitutes its stdout. | `HOSTNAME="$(hostname 2>/dev/null)"` |
| `"${BASH_SOURCE[0]}"` | **Script Path Introspection**: References the current script's relative or absolute location. | `SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"` |
| `"$variable"` | **Double Quoting**: Preserves whitespace and prevents accidental word splitting and globbing. | `kill "$target_pid"` |
| `${VAR}` | **Parameter Expansion**: Explicit variable boundary delimiter. | `"${db}.service"` |

---

### 3. Operators & Conditionals

#### Test Operators (`[ ... ]`)
- `[ -f "$file" ]` : True if the file exists and is a regular file.
- `[ -n "$str" ]` : True if string length is non-zero (not empty).
- `[ "$a" = "$b" ]` : True if string `$a` is equal to string `$b`.

#### Logical Operators
- `&&` (**AND**): Executes the right-hand command only if the left-hand command succeeds (`exit 0`).
  ```bash
  sudo systemctl restart "$svc_name" && echo "Success" || echo "Failed"
  ```
- `||` (**OR**): Executes the right-hand command only if the left-hand command fails (non-zero exit).
  ```bash
  hostname -I 2>/dev/null || echo "N/A"
  ```

---

### 4. Streams, Pipes & Redirections

```bash
# Standard Output to Pipe
ps aux | grep -i "nginx" | grep -v "grep"

# Suppress stderr (File Descriptor 2 -> /dev/null)
systemctl status "$svc_name" 2>/dev/null

# Suppress both stdout & stderr
command -v ufw >/dev/null 2>&1

# Write to privileged files using tee
echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1
```

---

### 5. Bash Builtins & Keywords

| Builtin / Keyword | Purpose | Code Usage Example |
|---|---|---|
| `echo` | Prints lines to stdout | `echo "Goodbye!"` |
| `printf` | Formatted printing (used for ANSI color codes) | `printf "\033[0;32m"` *(sets green text)* |
| `read -p` | Prompts user and reads variable | `read -p "Enter choice: " choice` |
| `source` / `.` | Imports functions and variables into current shell | `source "$module"` / `source /etc/os-release` |
| `exit 0` | Terminates script with successful status code | `exit 0` |
| `return 0` | Returns from a shell function | `return 0` |
| `clear` | Clears terminal viewport | `clear` |
| `command -v` | Checks if a binary/command exists in `$PATH` | `command -v docker >/dev/null 2>&1` |
| `break` | Exits from innermost loop | `break` |
| `continue` | Skips to next loop iteration | `continue` |
| `true` | Null command returning 0 exit code | `systemd-analyze blame \| head -n 10 \|\| true` |

---

### 6. Linux System & Diagnostic Utilities

#### System & Hardware
- `uname -r`, `uname -m`, `uname -s`: Query kernel release, architecture, and OS kernel name.
- `uptime -p`, `uptime`: Show how long the system has been running in pretty or raw format.
- `whoami`: Display current effective username.
- `date`: Display current system date and time.
- `nproc`: Print number of available processing units.
- `lscpu`: Display detailed CPU architecture information.
- `free -h`: Show human-readable RAM and Swap utilization.
- `df -h /`: Check disk space usage for root filesystem.
- `mpstat 1 1`: Display CPU statistics.
- `top -bn1`: Single-iteration batch mode output of top system processes.
- `sync`: Flush file system buffers to disk.

#### Networking
- `hostname`, `hostname -I`: Fetch hostname and all local IP addresses.
- `ip -br addr show`, `ip route`: Display network interfaces in brief format and routing tables.
- `ss -tuln`, `ss -tulnp`: Show listening TCP/UDP sockets with numerical addresses and process names.
- `curl -s --connect-timeout 2 ifconfig.me`: Silent external HTTP request to get public IP address.

#### Service & Init Systems (Systemd)
- `systemctl list-units --type=service --state=running`: List active services.
- `systemctl status <svc>`: Detailed status and recent log snippet for a unit.
- `systemctl start / stop / restart <svc>`: Manage unit lifecycle.
- `systemctl is-active <svc>`: Check if a unit is currently active (`active` / `inactive`).
- `systemctl --failed`: Inspect failed units.
- `systemctl list-timers`: List active scheduled systemd timers.
- `systemctl daemon-reload`: Reload systemd manager configuration.
- `systemd-analyze`, `systemd-analyze blame`: Inspect boot performance and startup service delays.
- `journalctl -n 30 --no-pager`: Retrieve the last 30 log lines without paging.
- `journalctl -u <svc>`: Filter journal logs by specific systemd service unit.

#### Process Management
- `ps aux --sort=-%cpu`: List all processes sorted descending by CPU utilization.
- `ps aux --sort=-%mem`: List all processes sorted descending by memory usage.
- `kill <PID>`: Send termination signal (`SIGTERM`) to target process.

#### Security & User Audits
- `who`, `w`: Show who is currently logged into the server.
- `lastb`: Display list of recent bad login attempts.
- `getent group sudo`: Query user database for members of administrative groups (`sudo`, `wheel`, `admin`).
- `ufw status verbose`: Check Ubuntu Uncomplicated Firewall status.
- `firewall-cmd --state`: Query RHEL/CentOS firewalld status.
- `iptables -L -n -v`: Inspect raw packet filter rules.

#### Maintenance & Package Managers
- `apt update`, `apt autoremove -y`, `apt clean`: Debian/Ubuntu package management & cleanup.
- `dnf check-update`, `dnf autoremove`, `dnf clean all`: Fedora/RHEL package tools.
- `find /tmp -type f -atime +7 -delete`: Locate and delete temporary files accessed over 7 days ago.

---

### 7. Text Processing & Stream Transformation

| Command | Options | Purpose in Project |
|---|---|---|
| `grep` | `-i` *(case-insensitive)* | Case-insensitive process searching (`grep -i "$proc_name"`) |
| `grep` | `-v` *(invert match)* | Filters out the grep search process itself (`grep -v "grep"`) |
| `grep` | `-m1` *(max count 1)* | Grabs only the first CPU model name line from `/proc/cpuinfo` |
| `grep` | `-c` *(count)* | Counts CPU cores from `/proc/cpuinfo` |
| `grep` | `-oP` *(only matching regex)* | Extracts IPv4 addresses using Perl-compatible positive lookbehind |
| `awk` | `'{print $3}'`, `-F` | Extracts specific columnar fields (e.g., gateway IP, load averages) |
| `cut` | `-d: -f2` | Delimits strings by `:` and selects field 2 (CPU model string extraction) |
| `xargs` | *(default)* | Trims leading and trailing whitespace from string outputs |
| `tr` | `'\n' ' '` | Translates newlines to spaces to format list output inline |
| `head` | `-n 10` | Limits output stream to the top 10 rows |
| `tail` | `-n 30` | Grabs the last 30 log entries |

---

## 💡 Best Practices Applied

1. **Portable Shebang**: Uses `#!/bin/bash` to ensure execution in a Bash shell environment.
2. **Proper Variable Quoting**: Wraps variables in double quotes (`"$var"`) to avoid word splitting and globbing bugs.
3. **No-Pager Flag Usage**: Passes `--no-pager` to `systemctl` and `journalctl` to prevent interactive terminal blocking inside CLI menus.
4. **Graceful Degradation**: Every critical system command provides safe fallbacks (`|| echo "N/A"`) ensuring the menu never crashes when running in restricted or containerized environments.
5. **Non-destructive Defaults**: Cleanups and process kills always require explicit user confirmation or input.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
