pipeline {
  agent {
    kubernetes {
      label 'stackgen'
    }
  }

  stages {
    stage('Provision AppStack') {
      steps {
        container('stackgen') {
          script {
            sh '''
              echo "=== Container Debug Info ==="
              echo "User: $(whoami)"
              echo "Working directory: $(pwd)"
              echo "Home directory: $HOME"
              
              # Check if /home/linuxbrew exists
              echo "=== Checking /home/linuxbrew ==="
              ls -la /home/ 2>/dev/null || echo "/home directory not accessible"
              
              # Search for stackgen anywhere
              echo "=== Searching for stackgen ==="
              find / -name stackgen -type f 2>/dev/null | head -10 || echo "stackgen not found"
              
              # Check for Homebrew in common locations
              echo "=== Checking Homebrew locations ==="
              [ -d "/home/linuxbrew/.linuxbrew" ] && echo "Found: /home/linuxbrew/.linuxbrew" || echo "Not found: /home/linuxbrew/.linuxbrew"
              [ -d "/opt/homebrew" ] && echo "Found: /opt/homebrew" || echo "Not found: /opt/homebrew"
              [ -d "/usr/local/Homebrew" ] && echo "Found: /usr/local/Homebrew" || echo "Not found: /usr/local/Homebrew"
              
              # Check what's in /home
              echo "=== Contents of /home ==="
              ls -la /home/ 2>/dev/null || echo "Cannot list /home"
              
              # Since Homebrew doesn't seem to be installed, we need to install it
              echo "=== Installing Homebrew and StackGen ==="
              export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
              
              # Install Homebrew if not present
              if [ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
                echo "Homebrew not found, installing..."
                NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" || export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
                brew install stackgenhq/stackgen/stackgen
              fi
              
              # Use full path to stackgen
              STACKGEN="/home/linuxbrew/.linuxbrew/bin/stackgen"
              
              echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
              
              # Verify tools are available
              $STACKGEN version
              terraform --version
              
              # Run provision command
              $STACKGEN provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply
            '''
          }
        }
      }
    }
  }
}
