pipeline {
    agent any
    tools {
        gradle 'Gradle8'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build with Gradle') {
            steps {
                bat 'gradle clean build jar'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t ogungultekin/devopspipeline:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                 withCredentials([string(credentialsId: 'dockerhub-token', variable: 'dockerhub-toke')]) {
                 //bat 'echo  %dockerhub-toke% '
                   bat 'docker login -u ogungultekin -p  %dockerhub-toke% '
                 }

            }

        }

        stage('Push Docker Image to DockerHub') {
            steps {
                bat 'docker push ogungultekin/devopspipeline:latest'
            }
        }


        stage('Cleanup Docker Image') {
          steps {
            script{
               withCredentials([string(credentialsId: 'dockerhub-token', variable: 'dockerhub-token')]) {
                 //  sh "docker rmi mimaraslan/devops-application:latest"
                bat 'docker rmi ogungultekin/devopspipeline:latest'
              }
            }
          }
        }


        stage('Deploy to Kubernetes') {
          steps {
             script{
                kubernetesDeploy (configs: 'deploymentservice.yaml', kubeconfigId: 'kubernetes')
             }
          }
        }
    }
}
