# Use the official Jenkins agent image as the base image
FROM jenkins/agent:alpine-jdk17

# Switch to root user to install dependencies
USER root

# Update packages
RUN apk update

# Install Docker CLI
RUN apk add --no-cache docker-cli

# Install Python3 and pip
ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache python3 pipx

# Switch back to jenkins user
USER jenkins
