node {
    // Define environment variables
    def NEXUS_URL = 'http://localhost:8082'
    def DOCKER_IMAGE = 'mvn-hello-world'
    
    // Define tools to be used
    def dockerTool = tool name: 'docker'
    def mavenTool = tool name: 'maven'

    // Stage: Checkout
    stage('Checkout') {
        git url: 'https://github.com/gem-Amogh/mvn-hello-world.git', branch: 'main'
        echo "Clone done"
    }

    // Stage: Build Maven Project
    stage('Build Maven Project') {
        bat "${mavenTool}/bin/mvn clean install"
    }

    // Stage: Build Docker Image
    stage('Build Docker Image') {
        bat "docker build -t ${DOCKER_IMAGE} ."
    }

    // Stage: Push Docker image to Nexus
    stage('Push Docker image to Nexus') {
        docker.withRegistry("${NEXUS_URL}", 'nexus') {
            docker.image("${DOCKER_IMAGE}:latest").push()
        }
        echo "Successfully pushed to Nexus repository"
    }

    // Stage: Deploy to Minikube
    stage('Deploy to Minikube') {
        withCredentials([file(credentialsId: 'k1', variable: 'KUBECONFIG')]) {
            bat "kubectl version"
            // Uncomment the following line to apply your deployment
            // bat "kubectl apply -f deployment.yaml"
        }
        echo "Deployment Successful....."
    }
}
