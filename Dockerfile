# Use the official Jenkins agent image as the base image
FROM hub.docker.zlabi.dev/jenkins/agent:alpine-jdk21

# Switch to root user to install dependencies
USER root

# Update packages
RUN apk update

# Install Docker CLI
RUN apk add --no-cache docker-cli

# Install Docker Compose V2 plugin
RUN apk add --no-cache docker-cli-compose@v2.29.2-r0

# Install Python3 and pip
ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache python3 pipx

# Install OpenSSH client
RUN apk add --no-cache openssh

# Install Node.js and npm
RUN apk add --no-cache nodejs npm

# Download and install Taskfile (task)
RUN wget -O /tmp/task_linux_amd64.tar.gz https://github.com/go-task/task/releases/download/v3.24.0/task_linux_amd64.tar.gz && \
    tar -xzf /tmp/task_linux_amd64.tar.gz -C /tmp && \
    mv /tmp/task /usr/local/bin/task && \
    chmod +x /usr/local/bin/task && \
    rm /tmp/task_linux_amd64.tar.gz

# Create a writable temp directory
RUN mkdir -p /home/jenkins/tmp && chmod 777 /home/jenkins/tmp

# Switch back to jenkins user
USER jenkins

# Set TMPDIR to the writable temp directory
ENV TMPDIR=/home/jenkins/tmp

# Default command to keep the container running
CMD ["/bin/sh"]
