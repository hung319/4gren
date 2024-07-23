# Start from the latest Ubuntu image
FROM ubuntu:latest

# Install git
RUN apt-get update && apt-get install -y git

# Clone the repository
RUN git clone https://github.com/MHSanaei/3x-ui.git /opt/3x-ui

# Change working directory
WORKDIR /opt/3x-ui

# Copy the db and cert directories to the container
VOLUME /opt/3x-ui/db /etc/x-ui
VOLUME /opt/3x-ui/cert /root/cert

# Set environment variable
ENV XRAY_VMESS_AEAD_FORCED=false

# Use the host network
NETWORK host

# Restart policy
LABEL restart="unless-stopped"

# Define the entrypoint
ENTRYPOINT ["docker", "run", "-itd", \
            "-e", "XRAY_VMESS_AEAD_FORCED=false", \
            "-v", "/opt/3x-ui/db/:/etc/x-ui/", \
            "-v", "/opt/3x-ui/cert/:/root/cert/", \
            "--network=host", \
            "--restart=unless-stopped", \
            "--name", "3x-ui", \
            "ghcr.io/mhsanaei/3x-ui:latest"]
