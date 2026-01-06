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
              # Debug: Check current user and environment
              echo "Current user: $(whoami)"
              echo "Current directory: $(pwd)"
              echo "HOME: $HOME"
              echo "PATH: $PATH"
              
              # Check if Homebrew directory exists
              echo "Checking for Homebrew..."
              ls -la /home/linuxbrew/.linuxbrew/bin/ 2>/dev/null || echo "Homebrew bin directory not found"
              
              # Try to find stackgen
              echo "Searching for stackgen..."
              find /home -name stackgen 2>/dev/null | head -5 || echo "stackgen not found in /home"
              
              # Set PATH explicitly
              export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
              
              # Try to load Homebrew if brew exists
              if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
                echo "Loading Homebrew environment..."
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
                echo "Updated PATH: $PATH"
              fi
              
              # Find stackgen command
              STACKGEN_CMD=""
              if command -v stackgen >/dev/null 2>&1; then
                STACKGEN_CMD="stackgen"
              elif [ -f "/home/linuxbrew/.linuxbrew/bin/stackgen" ]; then
                STACKGEN_CMD="/home/linuxbrew/.linuxbrew/bin/stackgen"
              else
                # Try to find it
                STACKGEN_CMD=$(find /home/linuxbrew -name stackgen -type f 2>/dev/null | head -1)
                if [ -z "$STACKGEN_CMD" ]; then
                  echo "ERROR: stackgen not found anywhere"
                  exit 1
                fi
              fi
              
              echo "Using stackgen at: $STACKGEN_CMD"
              echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
              
              # Verify tools are available
              $STACKGEN_CMD --version
              terraform --version
              
              # Run provision command
              $STACKGEN_CMD provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply
            '''
          }
        }
      }
    }
  }
}
