# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Update package lists and install desired packages
RUN apt-get update && \
    apt-get install -y \
       build-essential \
        cmake \
        ninja-build \
        qt6-default \
        # Add more packages as needed \
    && rm -rf /var/lib/apt/lists/*

# Add user 'trilla'
RUN useradd -m trilla

# Set the working directory
WORKDIR /trilla/code

# Create a named instance (e.g., 'my_ubuntu_instance')
LABEL instance_name="ubuntu-dev"

# Expose any necessary ports
# EXPOSE 80

# Command to run upon container start
CMD ["/bin/bash"]
