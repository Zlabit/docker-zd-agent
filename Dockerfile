# Use the official Jenkins agent image as the base image
FROM jenkins/agent:alpine-jdk17

# Switch to root user to install dependencies
USER root

# Install Docker CLI
RUN apk update && \
    apk add --no-cache docker-cli

# Install Python3 and pip
RUN apk update && \
    apk add --no-cahe py3-pip

# Switch back to jenkins user
USER jenkins

# Default command to keep the container running
CMD ["/bin/sh"]
