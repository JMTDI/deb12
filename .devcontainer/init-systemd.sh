#!/bin/bash
set -e

echo "Initializing systemd user session..."

# Start dbus if not running
if ! pgrep -x "dbus-daemon" > /dev/null; then
    echo "Starting dbus daemon..."
    dbus-daemon --config-file=/etc/dbus-1/system.conf --print-address
fi

# Create user systemd runtime directory
if [ -n "$SUDO_USER" ]; then
    mkdir -p /run/user/$(id -u $SUDO_USER)
    chmod 0700 /run/user/$(id -u $SUDO_USER)
    export XDG_RUNTIME_DIR=/run/user/$(id -u $SUDO_USER)
fi

echo "systemd initialization complete."
echo "To use systemctl commands, run: systemctl --user status (for user services)"
echo "Or: sudo systemctl status (for system services)"
