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
              
              # Check system tools
              echo "=== Checking system tools ==="
              which curl || echo "curl not in PATH"
              which git || echo "git not in PATH"
              /usr/bin/curl --version 2>/dev/null || echo "curl not at /usr/bin/curl"
              /usr/bin/git --version 2>/dev/null || echo "git not at /usr/bin/git"
              
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
              
              # Check what's in /usr/bin
              echo "=== Checking /usr/bin for common tools ==="
              ls -la /usr/bin/curl /usr/bin/git 2>/dev/null | head -5 || echo "Tools not found in /usr/bin"
              
              # Since Homebrew doesn't seem to be installed, we need to install it
              echo "=== Installing Homebrew and StackGen ==="
              export PATH="/usr/bin:/usr/sbin:/bin:/sbin:${PATH}"
              
              # Install Homebrew if not present
              if [ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
                echo "Homebrew not found, installing..."
                # Use full path to curl
                CURL_CMD=$(which curl || echo "/usr/bin/curl")
                if [ ! -f "$CURL_CMD" ]; then
                  echo "ERROR: curl not found. Installing basic tools..."
                  apt-get update && apt-get install -y curl git build-essential
                fi
                
                NONINTERACTIVE=1 /bin/bash -c "$($CURL_CMD -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
                /home/linuxbrew/.linuxbrew/bin/brew install stackgenhq/stackgen/stackgen
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
