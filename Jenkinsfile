/* Requires the Docker Pipeline plugin */
pipeline {
    agent any
    environment {
        CLOUDSDK_CORE_PROJECT='tp-4-gl5'
        CLIENT_EMAIL='jenkins-gcloud@tp-4-gl5.iam.gserviceaccount.com'
        GCLOUD_CREDS=credentials('gcloud-creds')
      }
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
	stage('push docker image'){
	steps{
		sh 'gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"'
		sh 'echo "Y" | gcloud auth configure-docker europe-west1-docker.pkg.dev'
		sh 'docker tag django-app  europe-west1-docker.pkg.dev/tp-4-gl5/django-app/django-app:latest'
		sh 'docker push europe-west1-docker.pkg.dev/tp-4-gl5/django-app/django-app:latest'		
}
}
    }
}
