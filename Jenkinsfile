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
              # Switch to jenkins user and run commands
              # Homebrew was installed as jenkins user, so we need to run as that user
              su - jenkins << 'EOF'
                # Load Homebrew environment
                export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
                
                echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
                echo "User: $(whoami)"
                echo "HOME: $HOME"
                echo "PATH: $PATH"
                
                # Verify tools are available
                stackgen --version
                terraform --version
                
                # Run provision command
                stackgen provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply
              EOF
            '''
          }
        }
      }
    }
  }
}
