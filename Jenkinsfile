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
              # Load Homebrew environment
              eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
              
              echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
              
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
