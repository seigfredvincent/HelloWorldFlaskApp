pipeline {
    agent any

    environment {
        // Set environment variables for SonarQube and Dependency-Check
        DEPENDENCY_CHECK_REPORT = 'dependency-check-report.xml'
        SONARQUBE_SERVER = 'SonarQube'  // SonarQube server configured in Jenkins
    }

    stages {
        stage('Clone') {
            steps {
                // Clone the repository from GitHub
                git branch: 'main', url: 'https://github.com/seigfredvincent/HelloWorldFlaskApp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image from the Dockerfile
                sh 'docker build -t flask-app-image .'
            }
        }

        stage('Run Tests in Docker') {
            steps {
                // Run the pytest tests inside the Docker container
                sh 'docker run --rm flask-app-image pytest test/'
                //sh 'docker run -d -p 5000:5000 flask-app-image' 
            }
        }

        stage('OWASP Dependency-Check') {
            steps {
                // Run OWASP Dependency-Check to generate a report on vulnerable dependencies
                sh '''
                    dependency-check --project "FlaskApp" --format "XML" --out ${DEPENDENCY_CHECK_REPORT} --scan .
                '''
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {  // This pulls the SonarQube server configuration
                    // Run SonarQube Scanner for static code analysis
                    sh '''
                        sonar-scanner \
                        -Dsonar.projectKey=FlaskApp \
                        -Dsonar.sources=. \
                        -Dsonar.python.version=3.x \
                        -Dsonar.dependencyCheck.reportPath=${DEPENDENCY_CHECK_REPORT} \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.login=$SONAR_AUTH_TOKEN
                    '''
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
