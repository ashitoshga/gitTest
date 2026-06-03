pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.60.0-jammy'
        }
    }

    stages {
        stage('Debug') {
            steps {
                sh 'node --version'
                sh 'npm --version'
                sh 'npx playwright --version'
            }
        }
    }
}