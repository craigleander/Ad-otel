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
              echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
              echo "User: $(whoami)"
              
              # Check if stackgen is available
              if command -v stackgen >/dev/null 2>&1; then
                STACKGEN="stackgen"
                echo "Found stackgen in PATH"
              elif [ -f "/usr/local/bin/stackgen" ]; then
                STACKGEN="/usr/local/bin/stackgen"
                export PATH="/usr/local/bin:${PATH}"
                echo "Found stackgen at /usr/local/bin/stackgen"
              else
                echo "ERROR: stackgen not found. Installing..."
                # Fallback: install stackgen directly
                curl -L "https://github.com/stackgenhq/stackgen/releases/download/v0.74.1/stackgen-linux-amd64" -o /usr/local/bin/stackgen
                chmod +x /usr/local/bin/stackgen
                export PATH="/usr/local/bin:${PATH}"
                STACKGEN="/usr/local/bin/stackgen"
              fi
              
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
