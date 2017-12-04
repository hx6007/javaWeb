// Declarative //
pipeline {
    agent any ①

    stages {
        stage('Build') { ②
            steps { ③
                sh 'make' ④
            }
        }
        stage('Test'){
            steps {
                sh 'make check'
                junit 'reports/**/*.xml' ⑤
            }
        }
        stage('Deploy') {
            steps {
                sh 'make publish'
            }
        }
    }
}
