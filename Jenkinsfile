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
        stage('Deploy to k8s'){
            steps{
                sh "chmod +x ChangeTag.sh"
                sh "./ChangeTag.sh ${DOCKER_TAG}"
                sshagent(['kubernetesFlou']) {
                    sh "scp -o StrictHostKeyChecking=no kubernetes-deploy-app.yaml KubernetesSvcFlou.yaml root@103.147.2.204:/root/"
                    script{
                        try{
                            sh "ssh root@103.147.2.204 kubectl apply -f ."
                        }catch(error){
                            sh "ssh root@103.147.2.204 kubectl create -f ."
                        }
                    }
                }
            }
        }
    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
