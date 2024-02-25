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
                script {
                  withCredentials([usernamePassword(credentialsId: 'dockerhub-token', passwordVariable: 'DOCKERHUB_TOKEN', usernameVariable: 'DOCKERHUB_USER')]) {
                   bat "echo %DOCKERHUB_TOKEN% | docker login -u %DOCKERHUB_USER% --password-stdin"
                 }
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                bat 'docker push ogungultekin/devopspipeline:latest'
            }
        }
    }
}
