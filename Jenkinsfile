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
                sh ''' ansible-playbook deploy/playbook.yaml '''
            }
        }
    }
}
