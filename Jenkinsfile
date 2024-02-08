pipeline {
    agent any
    
    stages {
        stage('Delete Workspace') {
            steps {
                deleteDir()
            }
        }
        stage('Checkout repo') {
            steps {
               sh "git clone 'https://github.com/arminazizyan99/flask-app.git'"
            }
        }
        stage('Docker image build') {
            steps {
               def dockerImage = docker.build("my-docker-image:latest")
            }
        }

        stage('Docker run build') {
            steps {
              def dockerImage = docker.image("my-docker-image:latest")
              def dockerContainer = dockerImage.run("-d -p 8080:80")
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
