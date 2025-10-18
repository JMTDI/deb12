#!/bin/bash
set -e

echo "=== Initializing Debian 12 with systemd ==="
echo ""

# Give systemd time to start fully
sleep 2

# Permanently disable nvidia-persistenced
echo "Disabling nvidia-persistenced service..."
sudo systemctl disable nvidia-persistenced.service 2>/dev/null || true
sudo systemctl mask nvidia-persistenced.service 2>/dev/null || true
sudo rm -f /etc/systemd/system/multi-user.target.wants/nvidia-persistenced.service 2>/dev/null || true

# Ensure journal directory exists and has correct permissions
echo "Setting up systemd journal..."
sudo mkdir -p /var/log/journal
sudo chmod 2755 /var/log/journal
sudo chown root:systemd-journal /var/log/journal

# Restart journald to pick up the directory
sudo systemctl restart systemd-journald

# Start dbus explicitly
echo "Starting dbus..."
sudo systemctl start dbus

# Create user runtime directory
echo "Setting up user runtime directory..."
mkdir -p /run/user/$(id -u)
chmod 0700 /run/user/$(id -u)
export XDG_RUNTIME_DIR=/run/user/$(id -u)

echo ""
echo "=== System Status ==="
sudo systemctl status --no-pager | head -15
echo ""

echo "=== Failed Units ==="
sudo systemctl list-units --failed --no-pager || echo "✓ No failed units!"
echo ""

echo "=== Quick Test Commands ==="
echo "  sudo systemctl status              - Full system status"
echo "  sudo journalctl -b --no-pager      - View system logs"
echo "  sudo journalctl -u <service>       - View service logs"
echo "  systemctl --user status            - User session status"
echo ""
echo "✓ systemd initialization complete!"
