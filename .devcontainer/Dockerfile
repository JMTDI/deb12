FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker

# Install systemd and essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    systemd systemd-sysv systemd-container \
    dbus dbus-user-session \
    ca-certificates curl wget git build-essential vim nano sudo \
    procps udev iproute2 iputils-ping \
  && rm -rf /var/lib/apt/lists/*

# Create a non-root developer user
RUN useradd -m -s /bin/bash -G sudo,systemd-journal developer \
  && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure dbus socket dir and uuid
RUN mkdir -p /var/run/dbus && dbus-uuidgen --ensure

# Create journal directory with proper permissions
RUN mkdir -p /var/log/journal && chmod 2755 /var/log/journal

# Configure journald for persistent storage
RUN sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf

WORKDIR /workspace

# Run systemd as PID 1 (init)
CMD ["/sbin/init"]
