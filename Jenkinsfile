pipeline {
    agent any
 
    environment {
        registry = "arminezyan/my-images" 
        registryCredential = 'DOCKERHUB'
        dockerImage = ''
    }
    stages {
        
        stage('Delete Workspace') {
            steps {
                deleteDir()
            }
        }
        
        stage('Checkout') {
                steps {
                sh "git clone https://github.com/arminazizyan99/flask-app.git"
                }
        }
        
        
        stage ('Clean Up'){
            steps{
                sh returnStatus: true, script: '$(docker ps -a)'
                sh returnStatus: true, script: 'docker stop $(docker ps -a | grep ${JOB_NAME} | awk \'{print $1}\')'
                sh returnStatus: true, script: 'docker rm -f $(docker ps -a | grep ${JOB_NAME} | awk \'{print $1}\')'
            }
        }

        stage('Build Image') {
            steps {
                script {
                    img = registry + ":push-from-jenkins-${env.BUILD_ID}"
                    println ("${img}")
                    dockerImage = docker.build("${img}", "-f flask-app/Dockerfile flask-app")
                }
            }
        }
        
        stage('Run docker image') {
           steps {
               script{ 
                sh label: 'run docker image', script: "docker run -d --name ${JOB_NAME} -p 5000:8080 ${img}"
                sh label: 'check app status', returnStdout: true, script: "curl -sS http://localhost:8080"
                // sh "echo \$?"
                // sh "if [[ \$? -ne 0]]; then exit 1 fi"
              }
            }
          }

        stage('Push To DockerHub') {
            steps {
                script {
                      docker.withRegistry( 'https://registry.hub.docker.com ', registryCredential ) {
                      dockerImage.push()
                     }
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
