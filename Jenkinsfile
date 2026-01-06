pipeline {
  agent {
    kubernetes {
      label 'stackgen'
    }
  }
  
  environment {
    // Add Homebrew to PATH
    PATH = "/home/linuxbrew/.linuxbrew/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${env.PATH}"
    // Disable Homebrew auto-update to speed up build
    HOMEBREW_NO_AUTO_UPDATE = "1"
  }

  stages {
    stage('Install Dependencies') {
      steps {
        container('stackgen') {
          script {
            // Install system dependencies - run as root for package installation
            // Then verify we can switch to jenkins user for subsequent operations
            sh '''
              # Install system packages as root
              apt-get update
              apt-get install -y sudo curl unzip git software-properties-common gnupg2 lsb-release build-essential
              curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
              apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
              apt-get update && apt-get install -y terraform
              
              # Ensure jenkins user can use sudo
              if ! grep -q "jenkins ALL=(ALL) NOPASSWD: ALL" /etc/sudoers 2>/dev/null; then
                echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
              fi
              
              # Verify jenkins user exists and switch to it
              su - jenkins -c "whoami && id"
            '''
            
            // Verify Terraform (run as jenkins user)
            sh 'su - jenkins -c "terraform --version"'
          }
        }
      }
    }

    stage('Install StackGen CLI') {
      steps {
        container('stackgen') {
          script {
            // Install Homebrew as non-root user following official instructions
            sh '''
              # Run everything as jenkins user
              su - jenkins << 'EOF'
                # Ensure we're in the home directory
                cd ~
                
                # Install Homebrew (non-interactive mode)
                # This will install to /home/linuxbrew/.linuxbrew
                NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                
                # Configure Homebrew for the shell
                echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
                
                # Apply the changes to current session
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
                
                # Install StackGen CLI
                brew install stackgenhq/stackgen/stackgen
                
                # Verification
                echo "=== StackGen CLI Version ==="
                stackgen --version
                echo "=== Terraform Version ==="
                terraform --version
              EOF
            '''
          }
        }
      }
    }

    stage('Provision AppStack') {
      steps {
        container('stackgen') {
          script {
            sh '''
              # Run as jenkins user to ensure Homebrew is in PATH
              su - jenkins << 'EOF'
                # Ensure Homebrew is in PATH
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" || true
                
                echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
                
                # Verify StackGen is accessible
                which stackgen
                stackgen --version
                
                # Running provision with --apply to execute changes non-interactively
                stackgen provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply
              EOF
            '''
          }
        }
      }
    }
  }
}
