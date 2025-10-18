FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

# Install systemd and essential packages
RUN apt-get update && apt-get install -y \
    systemd \
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
    && rm -rf /var/lib/apt/lists/* \
    && systemctl set-default multi-user.target

# Create non-root user
RUN useradd -m -s /bin/bash -G sudo,systemd-journal developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Setup dbus
RUN mkdir -p /var/run/dbus && \
    dbus-uuidgen --ensure

WORKDIR /workspace

# Use bash as the default entrypoint instead of init
ENTRYPOINT ["/bin/bash"]
