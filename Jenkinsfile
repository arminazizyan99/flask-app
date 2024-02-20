def CleanUp(){
     // stop rm docker container
     sh returnStatus: true, script: '$(docker ps -a)'
     sh returnStatus: true, script: 'docker stop $(docker ps -a | grep ${JOB_NAME} | awk \'{print $1}\')'
     sh returnStatus: true, script: 'docker rm -f $(docker ps -a | grep ${JOB_NAME} | awk \'{print $1}\')'
}

pipeline {
    agent any
 
    environment {
        registry = "arminezyan/my-images" 
        registryCredential = 'DOCKERHUB'
        dockerImage = ''
        img = "${registry}" + ":push-from-jenkins-${env.BUILD_ID}"
        GOOGLE_APPLICATION_CREDENTIALS = credentials('my-gcp-account')
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
        
        
        stage ('Clean Up 1'){
            steps{
                 script{
                       CleanUp()
                 }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build("${img}", "-f flask-app/Dockerfile flask-app")
                }
            }
        }
        
        stage('Run docker image') {
           steps {
               script{ 
                sh label: 'run docker image', script: "docker run -d --name ${JOB_NAME} -p 5000:8080 ${img}"
                sh "ps aux | grep 'python /usr/src/app/app.py'"
                sh label: 'check app url', returnStdout: true, script: "curl http://localhost:5000"
                sh label: 'echo last command status', script: "echo \$?"
                sh label: 'check status', script: "if [ \$? -ne 0 ]; then exit 1; fi"
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
        stage ('Clean Up 2'){
            steps{
                 script{
                       CleanUp()
                 }
            }
        }
        stage('Deploy to Cloud Run') {
            steps { 
                script{
                withCredentials([file(credentialsId: 'my-gcp-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    sh "gcloud run deploy flask-app --image=docker.io/${img} --platform=managed --project=my-test-project-414508 --region=europe-west1"
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
