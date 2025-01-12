pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'checkout'
                sh 'rm -rf mymp3'
                sh 'git clone https://github.com/homemlinux/mymp3.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Build'
                sh 'docker stop mymp3 || true'
                sh 'docker rm mymp3 || true'
                sh 'docker rmi mymp3 || true'
                dir('mymp3') { 
                    sh 'ls -la'
                    sh 'docker build -t mymp3 .'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'deploy'
                sh 'docker run -d --name mymp3 -p 8080:80 mymp3'
            }
        }
    }
}
