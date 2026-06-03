pipeline {
    agent {
        docker {
            image 'alpine:latest'
            reuseNode true
        }
    }

    stages {
        stage('Test') {
            steps {
                sh 'echo Inside Docker'
                sh 'whoami'
                sh 'pwd'
            }
        }
    }
}