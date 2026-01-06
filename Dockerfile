FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOMEBREW_NO_AUTO_UPDATE=1

# Create jenkins user
RUN useradd -m -u 1000 -s /bin/bash jenkins

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

# Switch to jenkins user for Homebrew installation
USER jenkins
WORKDIR /home/jenkins

# Install Homebrew
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Configure Homebrew
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc

# Install StackGen CLI
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install stackgenhq/stackgen/stackgen

# Set up PATH for Homebrew
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Keep container running
CMD ["cat"]

