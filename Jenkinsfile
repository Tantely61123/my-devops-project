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
                bat 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

stage('Build Docker Image') {
    steps {
        script {
            // Vérifiez d'abord que le fichier JAR existe
            bat 'dir target\\'
            
            // Construction de l'image avec le bon nom de fichier
            docker.build("tantely007/monprojetci:1.0.0")
        }
    }
}

        stage('Push DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpass', variable: 'dockerHubPass')]) {
                    bat "docker login -u $DOCKER_HUB_USER -p $dockerHubPass"
                    bat "docker push $IMAGE_NAME"
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
