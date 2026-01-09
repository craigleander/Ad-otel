pipeline {
    agent {
        kubernetes {
            inheritFrom 'stackgen-runner'
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
                            
                            # Verify tools are available (they should be pre-installed in the stackgen-runner template)
                            echo "Verifying tools..."
                            terraform --version || echo "Terraform check failed"
                            stackgen --version || echo "StackGen CLI check failed"
                            
                            # Run provision command
                            stackgen provision --appstack-id cb1cce4e-919c-4f1f-bf58-1590b7e19f6d --apply
                        '''
                    }
                }
            }
        }
    }
}
