node{
    registry = "ederd/flaskapp"
    tag = "v0.0.2"
    registryCredential = 'dockerhub'
    dockerImage = ""

    stage('Preparation'){
        checkout scm
        sh 'git rev-parse --short HEAD'
        sh 'pwd' 
    }

    stage('Linting'){
        sh 'pwd'
        def lintContainer = docker.image('python:3.7.3-stretch')
        lintContainer.pull()
        lintContainer.inside{
            sh """
                python3 -m venv venv
                . venv/bin/activate
                make install
                wget -O hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && \
                chmod +x hadolint
                make lint
            """            
        }
    }

    stage('Build blue image') {
        dockerImage = docker.build(registry+tag)
        sh "docker image ls"
        
    }

    stage('Push blue image') {
        docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
        }
    }

    stage('create the kubeconfig file') {
        sh'echo create the kubeconfig file' 
    }

    stage('Deploy blue container') {
        sh'echo Deploy blue container' 
    }

    stage('Redirect service to blue container') {
        sh'echo Redirect service to blue container' 
    }    
}
