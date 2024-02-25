pipeline {
    agent any
    tools{
        gradle 'Gradle8'
    }

    stages {
        stage('Build Gradle') {
            steps {
                // linux: sh 'maven clean install'
                // windows bat 'maven clean install'
                // linux: sh 'gradle clean'
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/OgunGultekin/DevOpsPipeline']])
                bat 'gradle clean'
                bat 'gradle build'
                bat 'gradle jar'
                //echo 'Hello World'
            }
        }
        stage('Docker Local') {
            steps {
                bat 'docker build -t ogungultekin/devopspipeline .'
            }
        }
        stage('Docker Image to DockerHub') {
            steps {
              script{
                  withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                   //sh 'echo docker login -u ogungultekin -p ${dockerhub}'
                   //sh 'docker push ogungultekin/devopspipeline:latest'
                   bat 'echo docker login -u ogungultekin -p ${dockerhub}'
                   bat 'docker push ogungultekin/devopspipeline:latest'
                }
              }
            }
        }
        /*
        stage('to Kubernates') {
            steps {
              script{
                 kubernetesDeploy configs: '', kubeConfig: [path: ''], kubeconfigId: 'kubernetes', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
              }
            }
        }
        */
    }
}
