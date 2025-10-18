#!/bin/bash
set -e

echo "=== Initializing Debian 12 with systemd support ==="

# Set environment variable for systemd
export container=docker

# Start dbus daemon
echo "Starting dbus daemon..."
if ! pgrep -x "dbus-daemon" > /dev/null; then
    dbus-daemon --system --nofork --nopidfile &
    sleep 1
fi

# Enable user systemd session
echo "Setting up user systemd session..."
mkdir -p /run/user/0
chmod 0700 /run/user/0
export XDG_RUNTIME_DIR=/run/user/0

# Verify systemd is working
echo "Verifying systemd setup..."
systemctl --version

echo ""
echo "=== Setup Complete ==="
echo "Usage:"
echo "  systemctl status                    - Check system services"
echo "  systemctl --user status             - Check user services"
echo "  sudo systemctl start <service>      - Start a system service"
echo "  systemctl --user start <service>    - Start a user service"
