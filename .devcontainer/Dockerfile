FROM debian:12

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install systemd and necessary dependencies
RUN apt-get update && apt-get install -y \
    systemd \
    systemd-container \
    dbus \
    ca-certificates \
    curl \
    wget \
    git \
    build-essential \
    vim \
    nano \
    bash-completion \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Configure systemd
RUN systemctl set-default multi-user.target

# Create a non-root user (optional, can be used instead of root)
RUN useradd -m -s /bin/bash -G sudo developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up dbus
RUN mkdir -p /var/run/dbus && \
    dbus-uuidgen --ensure

WORKDIR /workspace

CMD ["/sbin/init"]
