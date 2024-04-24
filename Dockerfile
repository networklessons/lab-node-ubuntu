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
    openssh-server
    && rm -rf /var/lib/apt/lists/*

# Add lab user for SSH.
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 lab
RUN  echo 'lab:lab' | chpasswd

EXPOSE 22
# Set the default command
CMD ["/usr/sbin/sshd","-D"]
#CMD ["/bin/bash"]
