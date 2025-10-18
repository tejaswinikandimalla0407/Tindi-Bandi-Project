pipeline {
    agent any
    triggers {
        githubPush()
    }
    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Tag for the Docker image')
    }
 
    environment {
        DOCKER_IMAGE = "cap-capstone-project:${params.IMAGE_TAG}"
        DOCKER_HUB_REPO = "srujans29/tindibandi-app"
        ECR_REPO = "636768524979.dkr.ecr.ap-east-1.amazonaws.com/srujan-capgemini"
    }
 
    stages {
        stage('Clone Repository') {
            steps {
                  git branch: 'master', url: 'https://github.com/tejaswinikandimalla0407/Tindi-Bandi-Project.git'
            }
        }
 
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
 
        stage('Login to  Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-Credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }
 
        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker tag ${DOCKER_IMAGE} ${DOCKER_HUB_REPO}:${params.IMAGE_TAG}"
                    sh "docker push ${DOCKER_HUB_REPO}:${params.IMAGE_TAG}"
                }
            }
        }
 
        stage('Login to AWS ECR') {
           steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-Credentials']]) {
                    script {
                        sh 'aws ecr get-login-password --region ap-east-1 | docker login --username AWS --password-stdin 636768524979.dkr.ecr.ap-east-1.amazonaws.com/srujan-capgemini'
                    }
                }
            }
        }
         stage('Deploying in Kubernetes') {
            steps {
                  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-Credentials']]){
                script {
                    sh "aws eks update-kubeconfig --name TindiBandi-app-cluster --region ap-east-1"
                     sh "kubectl apply -f mongodb-deployment.yaml"
                    sh "kubectl apply -f app-deployment.yaml"
 
                }
                  }
            }
        }
       
    }
 
    post {
        success {
            echo "Pipeline completed successfully. Image pushed and container deployed."
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
        always {
            echo "Cleaning up workspace..."
            cleanWs()
        }
    }
}
 