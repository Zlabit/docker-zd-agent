# Use the official Jenkins agent image as the base image
FROM jenkins/agent:alpine-jdk17

# Switch to root user to install dependencies
USER root

# Install Docker CLI
RUN apk update && \
    apk add --no-cache docker-cli

# Install Python3 and pip
RUN apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python && \
    python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools

# Switch back to jenkins user
USER jenkins

# Default command to keep the container running
CMD ["/bin/sh"]
