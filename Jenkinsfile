pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        JDK "jdk-17"
        maven "mvn-3.9"
    }
    stages {
        stage('Clone') {
            options {
                timeout(time: 2, unit: 'MINUTES') // kills hung git fetch
            }
            steps {
                git branch: 'main', changelog: false, poll: false,
                    url: 'https://github.com/spring-projects/spring-petclinic.git'
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
            }
        }
        stage('Run') {
            steps {
                sh "nohup java -jar target/spring-petclinic-*.jar --server.port=8888 > app.log 2>&1 &"
                sh "sleep 10"
            }
        }
        stage('Connectivity Test') {
            steps {
                sh " curl -kv localhost:8888 "
            }
        }
            }
        
    }
