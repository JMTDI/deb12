FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker

# Install systemd and essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    systemd systemd-sysv systemd-container dbus dbus-user-session \
    ca-certificates curl wget git build-essential vim nano sudo \
    procps udev iproute2 iputils-ping \
  && rm -rf /var/lib/apt/lists/*

# Create a non-root developer user
RUN useradd -m -s /bin/bash -G sudo,systemd-journal developer \
  && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure dbus socket dir and uuid
RUN mkdir -p /var/run/dbus && dbus-uuidgen --ensure

# Mask services that don't make sense in container
RUN systemctl mask systemd-remount-fs.service nvidia-persistenced.service

# Enable and configure journald for persistent logging
RUN mkdir -p /var/log/journal && \
    sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf

# Create systemd user runtime directory
RUN mkdir -p /run/user/1000 && chmod 0700 /run/user/1000

WORKDIR /workspace

# Run systemd as PID 1 (init)
CMD ["/sbin/init"]
