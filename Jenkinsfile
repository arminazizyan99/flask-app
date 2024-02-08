pipeline {
    agent any

    environment {
        // Define environment variables
        BUILD_VERSION = '1.0.0'
        IMAGE_NAME = 'my-docker-image'
        TAG = "${BUILD_VERSION}-${env.BUILD_NUMBER}"
    }

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
                script {
                    def dockerImage = docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    def dockerImage = docker.image("${IMAGE_NAME}:${TAG}")
                    def dockerContainer = dockerImage.run("-d", "-p", "8080:80")
                }
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
