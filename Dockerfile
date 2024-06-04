# Use the official Jenkins agent image as the base image
FROM dockerhub.zlabi.dev/jenkins/agent:alpine-jdk17

# Switch to root user to install dependencies
USER root

# Update packages
RUN apk update

# Install Docker CLI
RUN apk add --no-cache docker-cli

# Install Python3 and pip
ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache python3 pipx

# Install OpenSSH client
RUN apk add --no-cache openssh

# Install Node.js and npm
RUN apk add --no-cache nodejs npm

# Download and install Taskfile (task)
RUN wget -O /usr/local/bin/task https://github.com/go-task/task/releases/download/v3.24.0/task_linux_amd64.tar.gz && \
    tar -xzf /usr/local/bin/task_linux_amd64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/task && \
    rm /usr/local/bin/task_linux_amd64.tar.gz

# Create a writable temp directory
RUN mkdir -p /home/jenkins/tmp && chmod 777 /home/jenkins/tmp

# Switch back to jenkins user
USER jenkins

# Set TMPDIR to the writable temp directory
ENV TMPDIR=/home/jenkins/tmp

# Default command to keep the container running
CMD ["/bin/sh"]
