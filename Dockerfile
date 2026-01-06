FROM homebrew/brew:latest

# Switch to root for system operations
USER root

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Set PATH to include Homebrew (already set in base image, but ensure it's there)
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Check if user 1000 exists, if not create jenkins user
RUN id 1000 2>/dev/null || useradd -m -u 1000 -s /bin/bash jenkins

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    unzip \
    git \
    software-properties-common \
    gnupg2 \
    lsb-release \
    ca-certificates \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Configure sudo for jenkins user
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y terraform && \
    rm -rf /var/lib/apt/lists/*

# Install StackGen CLI using Homebrew (Homebrew is already installed in base image)
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install stackgenhq/stackgen/stackgen

# Verify stackgen is accessible
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    which stackgen && \
    stackgen version

# Switch to jenkins user for default operations
USER jenkins
WORKDIR /home/jenkins

# Keep container running
CMD ["cat"]

