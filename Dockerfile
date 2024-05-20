# Use the official Jenkins agent image as the base image
FROM jenkins/agent:alpine-jdk17

# Set the user to install depenedencies
USER root

# Install Docker CLI
RUN apk update && \
    apk add --no-cache docker-cli
# Verify the installation
RUN docker --version

# Install Python
RUN apk update && \
    add --no-cache python3 && \
    ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Set the user to 'jenkins' to match the base image
USER jenkins

# Default command to keep the container running
CMD ["/bin/sh"]
