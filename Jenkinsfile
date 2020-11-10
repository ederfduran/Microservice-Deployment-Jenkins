pipeline{
    agent any
    stage(‘Linting'){
        steps{
            sh'echo start Linting' 
        }
    }
    stage('Build blue image') {
        steps{
            sh'echo start Build' 
        }
    }
    stage('Push blue image') {
        steps{
            sh'echo start Push' 
        }
    }
    stage('create the kubeconfig file') {
        steps{
            sh'create the kubeconfig file' 
        }
    }
    stage('Deploy blue container') {
        steps{
            sh'Deploy blue container' 
        }
    }
    stage('Redirect service to blue container') {
        steps{
            sh'Redirect service to blue container' 
        }
    }    
}
