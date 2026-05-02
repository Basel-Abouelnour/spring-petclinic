pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('docker-username-password')
    }
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        jdk "jdk-17"
        maven "mvn-3.9"
    }
    stages {
        stage('Clone') {
            options {
                timeout(time: 2, unit: 'MINUTES') // kills hung git fetch
            }
            steps {
                git branch: 'main', changelog: false, poll: false,
                    url: 'https://github.com/Basel-Abouelnour/spring-petclinic.git'
            }
        }
        stage('Change Application Port'){
            steps {
                sh 'echo server.port=8888 >> src/main/resources/application.properties'
            }
        }
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                // Run Maven on a Unix agent.
                sh "mvn clean compile"
            }
        }
        stage('Test') {
            steps {
                // Get some code from a GitHub repository
                // Run Maven on a Unix agent.
                sh "mvn test"
            }
        }
        stage('Package') {
            steps {
                // Get some code from a GitHub repository
                // Run Maven on a Unix agent.
                sh "mvn package"
                sh "ls"
            }
        }
        stage('Cleaning Old Docker Images') {
            steps {
                sh "docker image prune --force"
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_CREDS_USR/spring-app:`date +%Y%m%d-%H%M%S` .'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh '''
                echo "$DOCKER_CREDS_PSW" | docker login -u "$DOCKER_CREDS_USR" --password-stdin
                docker tag $DOCKER_CREDS_USR/spring-app:`date +%Y%m%d-%H%M%S` $DOCKER_CREDS_USR/spring-app:latest
                docker push "$DOCKER_CREDS_USR/spring-app:latest"
                docker push "$DOCKER_CREDS_USR/spring-app:`date +%Y%m%d-%H%M%S`"
                '''
                }
            }
    }
    post { 
        always { 
            sh 'docker rm --force $(docker ps -aq)'
            sh 'docker system prune --force --all'
        }   
    }
}
