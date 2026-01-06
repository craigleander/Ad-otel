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
            // Install Terraform
            sh '''
              apt-get update
              apt-get install -y curl unzip git software-properties-common gnupg2 lsb-release
              curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
              apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
              apt-get update && apt-get install -y terraform
            '''
            
            // Verify Terraform
            sh 'terraform --version'
          }
        }
      }
    }

    stage('Install StackGen CLI') {
      steps {
        container('stackgen') {
          script {
            // Install dependencies required for Homebrew/StackGen if missing
            sh 'apt-get update && apt-get install -y build-essential curl git'
            
            // Install Homebrew
            sh 'NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
            
            // Install StackGen CLI
            sh 'brew install stackgenhq/stackgen/stackgen'
            
            // Verification
            sh 'stackgen --version'
            sh 'terraform --version'
          }
        }
      }
    }

    stage('Provision AppStack') {
      steps {
        container('stackgen') {
          script {
            echo "Starting Provisioning for AppStack: cb1cce4e-919c-4f1f-bf58-1590b7e19f6d"
            
            // Running provision with --apply to execute changes non-interactively
            sh 'stackgen provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply'
          }
        }
      }
    }
  }
}
