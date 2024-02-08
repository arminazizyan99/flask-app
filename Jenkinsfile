pipeline {
    agent {
        docker {
            image 'docker:19.03.12'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    
    environment {
        DOCKER_IMAGE = 'my-flask-app:fromJenkins'
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
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Docker run build') {
            steps {
                sh "docker run -d -p 80:8080 $DOCKER_IMAGE"
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
