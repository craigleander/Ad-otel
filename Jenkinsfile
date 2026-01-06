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
              # Load Homebrew environment (installed system-wide)
              export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
              eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
              
              echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
              echo "User: $(whoami)"
              echo "PATH: $PATH"
              
              # Verify tools are available
              stackgen --version
              terraform --version
              
              # Run provision command
              stackgen provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply
            '''
          }
        }
      }
    }
  }
}
