pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/seigfredvincent/HelloWorldFlaskApp.git'
            }
        }
        stage('Build') {
            steps {
                sh './build.sh' // For Java: mvn clean package
            }
        }
        stage('Test') {
            steps {
                sh 'pytest tests/' // For Python
            }
        }
        stage('Security Scan') {
            steps {
                sh 'dependency-check --scan ./ --out report'
            }
        }
    }
}
