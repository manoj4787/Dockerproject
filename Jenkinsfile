pipeline { 
    agent any

    environment {
        registry = "sen31088"  // Replace with your Docker registry URL
        imageName = "webapp"  // Replace with your desired image name
        containerName = "my-webapp-container"  // Replace with your desired container name
        dockerfilePath = "./Dockerfile"  // Replace with the path to your Dockerfile
        dockerArgs = "-p 8080:80"  // Replace with your desired container arguments
        version = sh(script: 'jq \'.version\' version.json', returnStdout: true).trim()
    }
    stages {
        stage('Clean WS') { 
            steps { 
                cleanWs()
            }
        }
        stage('SCM'){
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'sen', url: 'https://github.com/sen31088/app1.git']])
            }
        }
        
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: docker-sen31088, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                }
            }
        }

        stage('Build') {
            steps {
                
                sh "docker build -t ${registry}/${imageName}:${version} -f ${dockerfilePath} ."
            }
        }
        
        stage('Push to Artifcatory') {
            steps {
                sh "docker push ${registry}/${imageName}:${version}"
            }
        }


        stage('Deploy') {
            steps {
                sh "docker run -d --name ${containerName} ${dockerArgs} ${registry}/${imageName}:${version}"
            }
        }
    }
}
