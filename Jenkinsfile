pipeline {
    agent any

    environment {
        // Set environment variables for SonarQube and Dependency-Check
        DEPENDENCY_CHECK_REPORT = 'dependency-check-report.xml'
        SONARQUBE_SERVER = 'SonarQube'  // SonarQube server configured in Jenkins
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_AUTH_TOKEN = 'sqa_99b3956cad1620d4d1823b52f85fd63e3e79db18'
    }

    stages {
        stage('Clone') {
            steps {
                // Clone the repository from GitHub
                git branch: 'main', url: 'https://github.com/seigfredvincent/HelloWorldFlaskApp.git'
            }
        }

        stage('Build') {
            steps {
                // Build the Docker image from the Dockerfile
                sh 'docker build -t flask-app-image .'
            }
        }

        stage('Test') {
            steps {
                // Run pytest inside the Docker container
                sh 'docker run --rm flask-app-image pytest tests/test_app.py'
            }
        }

        stage('OWASP Dependency-Check') {
            steps {
                // After installing the plugin and setting up the global settings
                dependencyCheck additionalArguments: '', odcInstallation: 'OWASP-DC'
                // Run OWASP Dependency-Check to generate a report on vulnerable dependencies
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
        }

        stage('Code Analysis') {
            steps {
                //sh 'sonar-scanner'
                /**withSonarQubeEnv('SonarQube') {  // 'SonarQube' is the name of your server setup in Jenkins
                    sh '''
                        sonar-scanner \
                        -Dsonar.projectKey=FlaskApp \
                        -Dsonar.sources=. \
                        -Dsonar.python.version=3.x \
                        -Dsonar.dependencyCheck.reportPath=dependency-check-report.xml \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.login=sqa_99b3956cad1620d4d1823b52f85fd63e3e79db18
                    '''
                }**/
                def scannerHome = tool 'SonarQ';
                    withSonarQubeEnv() {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        /**
        stage('Security Scan') {
            steps {
                // Optionally, run Python dependency and security checks
                sh 'pip install safety bandit'
                sh 'safety check'
                sh 'bandit -r .'
            }
        }
        **/
    }

    post {
        always {
            // Clean up Docker containers after the build
            sh 'docker system prune -f'
        }

        success {
            // Publish the OWASP Dependency-Check report
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }

        failure {
            // Actions on failure
            echo 'Build failed, please check logs!'
        }
    }
}
