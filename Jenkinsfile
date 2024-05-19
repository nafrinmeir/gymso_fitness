pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nginx'
        DOCKER_TAG = 'latest'
        CONTAINER_NAME = 'my_fitness_app'
        REPO_URL = 'https://github.com/nafrinmeir/gymso_fitness.git'
        REPO_DIR = 'class'
    }

    stages {
        stage('Cleanup') {
            steps {
                script {
                    // Clean up the existing directory
                    sh 'rm -rf ${REPO_DIR}'
                    // Stop and remove existing Docker container if it exists
                    sh '''
                    if [ $(docker ps -a -q -f name=${CONTAINER_NAME}) ]; then
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                    fi
                    '''
                }
            }
        }

        stage('Clone Repository') {
            steps {
                script {
                    // Clone the public repository
                    sh 'git clone ${REPO_URL} ${REPO_DIR}'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Navigate to the repository directory and build the Docker image
                    dir("${REPO_DIR}") {
                        sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop any service using the port (e.g., another container)
                    sh '''
                    if [ $(lsof -t -i:8083) ]; then
                        kill -9 $(lsof -t -i:8083) || true
                    fi
                    '''
                    // Run the Docker container with a specific name
                    sh 'docker run -d --name ${CONTAINER_NAME} -p 8083:81 ${DOCKER_IMAGE}:${DOCKER_TAG}'
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace after the build
            cleanWs()
        }
    }
}
