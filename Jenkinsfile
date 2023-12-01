/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'python:3.9-alpine' } }
    stages {
	
        stage('install requirements') {
            steps {
	//	sh 'virtualenv venv -p python'
	//	sh 'source venv/bin/activate'
                sh 'pip install -r app/requirements.txt'
            }
        }
        stage('migrate database') {
            steps {
                sh 'python app/manage.py migrate'
            }
        }
        stage('run unit tests') {
            steps {
                sh 'python app/manage.py test'
            }
        }
    }
}
