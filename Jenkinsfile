pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/your-repo/sample-app.git'
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
