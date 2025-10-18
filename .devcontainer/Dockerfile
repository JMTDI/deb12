FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker

# Install systemd and essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    systemd systemd-sysv systemd-container systemd-journal-remote \
    dbus dbus-user-session \
    ca-certificates curl wget git build-essential vim nano sudo \
    procps udev iproute2 iputils-ping \
  && rm -rf /var/lib/apt/lists/*

# Create a non-root developer user
RUN useradd -m -s /bin/bash -G sudo,systemd-journal developer \
  && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure dbus socket dir and uuid
RUN mkdir -p /var/run/dbus && dbus-uuidgen --ensure

# Create persistent journal directory BEFORE masking services
RUN mkdir -p /var/log/journal && chmod 2755 /var/log/journal

# Configure journald for persistent storage
RUN sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf && \
    sed -i 's/#RateLimitIntervalSec=30s/RateLimitIntervalSec=10s/' /etc/systemd/journald.conf && \
    sed -i 's/#RateLimitBurst=10000/RateLimitBurst=10000/' /etc/systemd/journald.conf

# Mask services that don't make sense in container
RUN systemctl mask \
    systemd-remount-fs.service \
    systemd-udevd.service \
    systemd-udev-trigger.service \
    nvidia-persistenced.service

# Create systemd user runtime directories
RUN mkdir -p /run/user/1000 && chmod 0700 /run/user/1000 && \
    mkdir -p /run/user/0 && chmod 0700 /run/user/0

WORKDIR /workspace

# Run systemd as PID 1 (init)
CMD ["/sbin/init"]
