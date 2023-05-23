pipeline { 
    agent any
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
        stage('Deploy') {
            steps {
                sh ''' # copy index.html to appserver 1
 
                        echo "Copying Index.html to APP server1"
                        scp index.html root@10.0.4.43:/var/www/html/
                        
                        echo "Checking if the file is updated"
                        ssh root@10.0.4.43 "cat /var/www/html/index.html"
                        
                        echo "Deployment Done" '''
            }
        }
    }
}
