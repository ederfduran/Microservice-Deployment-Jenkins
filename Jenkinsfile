node{
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
                sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && \
                chmod +x /bin/hadolint
                make lint
            """            
        }
    }

    stage('Build blue image') {
        sh 'pwd'
        sh'echo start Build' 
    }

    stage('Push blue image') {
        sh'echo start Push' 
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
