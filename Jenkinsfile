pipeline {
    agent {
        docker {
            image 'docker:19.03.12' // Docker-in-Docker-capable Docker image
            args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount Docker socket
        }
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t my-flask-app:fromJenkins .'
            }
        }
    }
}
