# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Set the root password
RUN echo 'root:1' | chpasswd

# Update package lists and install desired packages
RUN apt-get update && \
    apt-get install -y \
       build-essential \
        cmake \
        ninja-build \
        curl \
        zip \
        unzip \
        tar \
        git \
        libssl-dev \
        python3.10-venv \
        libgl1-mesa-dev \
        libpulse-dev \
        libxcb-glx0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-render0 \
        libxcb-shape0 \
        libxcb-shm0 \
        libxcb-sync1 \
        libxcb-util1 \
        libxcb-xfixes0 \
        libxcb-xinerama0 \
        libxcb1 \
        libxkbcommon-dev \
        libxcb-xkb-dev \
        freeglut3-dev \
        python3-pip \
        openssh-client

RUN pip3 install aqtinstall

RUN apt-get install -y \
      ca-certificates \
      gpg \
      wget
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN apt-get update
RUN rm /usr/share/keyrings/kitware-archive-keyring.gpg
RUN apt-get install -y kitware-archive-keyring
RUN apt-get install -y cmake


RUN rm -rf /var/lib/apt/lists/*

# Add user 'trilla'
RUN useradd -m trilla

USER trilla

# Set the working directory
WORKDIR /home/trilla/code

# Create a named instance (e.g., 'my_ubuntu_instance')
LABEL instance_name="ubuntu-dev"

# Expose any necessary ports
# EXPOSE 80

# Command to run upon container start
CMD ["/bin/bash"]
