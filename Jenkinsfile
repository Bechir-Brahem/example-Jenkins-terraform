/* Requires the Docker Pipeline plugin */
pipeline {
    agent any
    stages {
	
        stage('install dependencies and test application') {
	    agent { docker { image 'python:3.9-alpine' } }
	    environment {
		HOME = "${env.WORKSPACE}"
	    }
            steps {
                sh 'pip install -r app/requirements.txt'
                sh 'python app/manage.py migrate'
                sh 'python app/manage.py test'
            }
        }
	stage('build docker image'){
	    steps {
	        sh 'docker build -t django-app .'
	    }
	}
    }
}
