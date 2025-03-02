pipeline {
    agent {
        node {
            label 'docker-zd-agent'
        }
    }
    environment {
        DOCKER_REPO = 'repo.docker.zlabi.dev/docker-zd-agent'
        DOCKER_CREDENTIALS_ID = 'nexus-jenkins'
        DOCKER_REPO_LINK = 'https://repo.docker.zlabi.dev/'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("${env.DOCKER_REPO}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image to private Repo') {
            steps {
                script {
                    docker.withRegistry("${env.DOCKER_REPO_LINK}", "${env.DOCKER_CREDENTIALS_ID}") {
                        def app = docker.build("${env.DOCKER_REPO}:${env.BUILD_ID}")
                        app.push()
                        app.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
