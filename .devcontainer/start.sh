#!/bin/bash
set -e

echo "=== Initializing Debian 12 with systemd ==="
echo ""

# Verify systemd is running as PID 1
if [ "$(cat /proc/1/comm)" != "systemd" ]; then
    echo "❌ ERROR: systemd is not running as PID 1!"
    ps -p 1
    exit 1
fi

echo "✓ systemd is running as PID 1"
echo ""

# Permanently disable nvidia-persistenced
echo "Disabling nvidia-persistenced service..."
sudo systemctl disable nvidia-persistenced.service 2>/dev/null || true
sudo systemctl mask nvidia-persistenced.service 2>/dev/null || true

# Ensure journal directory exists
echo "Setting up systemd journal..."
sudo mkdir -p /var/log/journal
sudo chmod 2755 /var/log/journal

# Restart journald
sudo systemctl restart systemd-journald

# Start dbus
echo "Starting dbus..."
sudo systemctl start dbus

# Create user runtime directory
mkdir -p /run/user/$(id -u)
chmod 0700 /run/user/$(id -u)
export XDG_RUNTIME_DIR=/run/user/$(id -u)

echo ""
echo "=== System Status ==="
systemctl status --no-pager | head -15
echo ""

echo "=== Failed Units ==="
systemctl list-units --failed --no-pager || echo "✓ No failed units!"
echo ""

echo "✓ systemd initialization complete!"
