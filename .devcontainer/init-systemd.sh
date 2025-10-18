#!/bin/bash
set -e

echo "=== Initializing Debian 12 with systemd support ==="
echo ""

# Wait for systemd-journald to start
echo "Waiting for journald to initialize..."
sleep 2

# Start dbus service explicitly
echo "Starting dbus service..."
systemctl start dbus || true
sleep 1

# Enable user session
echo "Starting user-runtime-dir service..."
systemctl start systemd-logind || true
sleep 1

# Create and setup runtime directories
mkdir -p /run/user/0
chmod 0700 /run/user/0
export XDG_RUNTIME_DIR=/run/user/0

# Verify journal is working
echo ""
echo "=== Systemd Status ==="
systemctl status systemd-journald.service || true
echo ""

# Show current state
echo "=== System Overview ==="
systemctl status --no-pager || true
echo ""

echo "=== Failed Units ==="
systemctl list-units --failed --no-pager || true
echo ""

echo "=== Quick Commands ==="
echo "View system logs:        sudo journalctl -b --no-pager | tail -50"
echo "View recent logs:        sudo journalctl -e"
echo "View service logs:       sudo journalctl -u SERVICE_NAME"
echo "System status:           sudo systemctl status"
echo "List failed units:       sudo systemctl list-units --failed"
