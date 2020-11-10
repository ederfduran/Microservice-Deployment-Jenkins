node{
    stage('Preparation'){
        checkout scm
        sh 'git rev-parse --short HEAD'
        sh 'pwd' 
    }

    stage('Linting'){
        sh 'pwd'
        sh'echo start Linting' 
    }

    stage('Build blue image') {
        sh 'pwd'
        sh'echo start Build' 
    }

    stage('Push blue image') {
        sh'echo start Push' 
    }

    stage('create the kubeconfig file') {
        sh'create the kubeconfig file' 
    }

    stage('Deploy blue container') {
        sh'Deploy blue container' 
    }

    stage('Redirect service to blue container') {
        sh'Redirect service to blue container' 
    }    
}
