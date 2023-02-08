pipeline{
    //agent any
     agent {label 'slave'}
    options{
        buildDiscarder(logRotator(daysToKeepStr: '15'))
        disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
        retry (3)
    }
    parameters{
        string(name: 'BRANCH', defaultValue: 'main')
        }
   
    stages{
            stage('Git Checkout'){
        steps{
            checkout scm
        }
        }
     
       stage('Build and Push'){
        steps{
            sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 028725692999.dkr.ecr.us-east-1.amazonaws.com"
            sh "docker build -t 028725692999.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment:v${BUILD_NUMBER} ."
            sh "docker push 028725692999.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment:v${BUILD_NUMBER}"
        }
       }
        stage('Deploy'){
         steps{
             sh '''
             docker pull 028725692999.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment:v${BUILD_NUMBER}
             if ("$( docker container inspect -f '{{.State.Running}}' upgrad-assignment )" == "true")
             then docker rm -f upgrad-assignment
             fi
             docker run -itd -p 3000:3000 --name upgrad-assignment 028725692999.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment:v${BUILD_NUMBER} 
             '''
            }
        }
       
    }
    post{
        always{
            sh "echo running final steps"
        }
    }

}