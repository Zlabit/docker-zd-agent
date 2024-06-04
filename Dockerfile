# Use the official Jenkins agent image as the base image
FROM dockerhub.zlabi.dev/jenkins/agent:alpine-jdk17

# Switch to root user to install dependencies
USER root

# Create a writable temp directory
RUN mkdir -p /home/jenkins/tmp && chmod 777 /home/jenkins/tmp

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

RUN wget -O /home/jenkins/tmp https://github.com/go-task/task/releases/download/v3.37.2/task_linux_amd64.tar.gz && \
    tar -xzf /home/jenkins/tmp/task_linux_amd64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/task && \
    rm /tmp/task_linux_amd64.tar.gz

# Switch back to jenkins user
USER jenkins

# Set TMPDIR to the writable temp directory
ENV TMPDIR=/home/jenkins/tmp

# Default command to keep the container running
CMD ["/bin/sh"]
