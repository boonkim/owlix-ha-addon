pipeline {
  agent any
  options {
    skipDefaultCheckout true
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'docker build -t owlix-ha-addon:latest .'
      }
    }
    stage('Deploy') {
      steps {
        sh 'docker compose up -d --force-recreate'
      }
    }
  }
}
