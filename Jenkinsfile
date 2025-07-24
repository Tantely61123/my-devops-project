pipeline {
    agent any

    tools {
        maven 'Maven 3.9.11'
    }

    environment {
        DOCKER_HUB_USER = 'tantely007'
        IMAGE_NAME = 'tantely007/monprojetci:1.0.0'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Tantely61123/my-devops-project.git',
                        credentialsId: 'git_credentials'
                    ]]
                ])
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Push DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpass', variable: 'dockerHubPass')]) {
                    sh "docker login -u $DOCKER_HUB_USER -p $dockerHubPass"
                    sh "docker push $IMAGE_NAME"
                }
            }
        }
    }

    post {
        failure {
            emailext(
                subject: "Build échoué : #${env.BUILD_NUMBER}",
                body: "Le build a échoué à l'étape : ${env.STAGE_NAME}",
                to: "frakotondramanitra@gmail.com"
            )
        }
    }
}
