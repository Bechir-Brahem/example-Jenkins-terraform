/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'python:3.9-alpine' } }
	    environment {
		HOME = "${env.WORKSPACE}"
	    }
    stages {
	
        stage('install requirements') {
            steps {
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
	stage('build docker image){
		steps{
			sh 'docker build -t django-app .'
}
}
    }
}
