# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update apt cache and install networking tools
RUN apt-get update && apt-get install -y \
    vim \
    iputils-ping \
    iproute2 \
    curl \
    netcat \
    dnsutils \
    nmap \
    iperf3 \
    hping3 \
    && rm -rf /var/lib/apt/lists/*

# Set the default command
CMD ["/bin/bash"]
