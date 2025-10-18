FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker

# Install systemd and essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    systemd \
    systemd-sysv \
    systemd-container \
    dbus \
    dbus-user-session \
    ca-certificates \
    curl \
    wget \
    git \
    build-essential \
    vim \
    nano \
    bash-completion \
    sudo \
    procps \
    udev \
    iproute2 \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Mask unnecessary systemd services for container
RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-logind.service

# Create non-root user
RUN useradd -m -s /bin/bash -G sudo,systemd-journal developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Setup dbus
RUN mkdir -p /var/run/dbus && \
    dbus-uuidgen --ensure

WORKDIR /workspace

CMD ["/lib/systemd/systemd-entrypoint", "bash"]
