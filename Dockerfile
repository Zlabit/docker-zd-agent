# Use the official Jenkins agent image as the base image
FROM jenkins/agent:alpine-jdk17

# Install Docker CLI
RUN apk update && \
    apk add --no-cache docker-cli

# Verify the installation
RUN docker --version

# Set the user to 'jenkins' to match the base image
USER jenkins

# Default command to keep the container running
CMD ["/bin/sh"]
