pipeline{
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t bayusantiko/flou:${DOCKER_TAG}"
            }
        }
        stage('Push Image DockerHub'){
            steps{
                withCredentials([string(credentialsId: 'bayusantiko', variable: 'dockerHubPass')]) {
                    sh "docker login -u bayusantiko -p ${dockerHubPass}"
                    sh "docker push bayusantiko/flou:${DOCKER_TAG}"
                }
            }
        }
    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
