#!/bin/bash
set -e

echo "=== Initializing Debian 12 with systemd support ==="

# Start dbus if not running
if ! pgrep -x "dbus-daemon" > /dev/null; then
    echo "Starting dbus daemon..."
    /etc/init.d/dbus start || true
fi

# Setup XDG_RUNTIME_DIR for current user
if [ -n "$SUDO_USER" ]; then
    USER_ID=$(id -u $SUDO_USER)
    mkdir -p /run/user/$USER_ID
    chmod 0700 /run/user/$USER_ID
fi

# Create journal directory
mkdir -p /var/log/journal
chmod 2755 /var/log/journal

echo ""
echo "=== Setup Complete ==="
echo ""
echo "System Status:"
sudo systemctl status --no-pager || true
echo ""
echo "Usage:"
echo "  sudo systemctl status                    - Check system services"
echo "  sudo systemctl --user status             - Check user services"
echo "  sudo systemctl start <service>           - Start a system service"
echo "  sudo journalctl -b                       - View system logs"
echo "  sudo journalctl -u <service>             - View service logs"
