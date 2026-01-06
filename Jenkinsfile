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
              # Set PATH to include Homebrew (installed system-wide)
              export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
              
              # Use full path to stackgen (more reliable)
              STACKGEN="/home/linuxbrew/.linuxbrew/bin/stackgen"
              
              echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
              echo "User: $(whoami)"
              echo "PATH: $PATH"
              
              # Verify stackgen exists
              if [ ! -f "$STACKGEN" ]; then
                echo "ERROR: stackgen not found at $STACKGEN"
                ls -la /home/linuxbrew/.linuxbrew/bin/ | head -20
                exit 1
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
