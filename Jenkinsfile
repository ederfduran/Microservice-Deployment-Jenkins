node{
    registry = "ederd/flaskapp"
    versionTag = "v0.0.2"
    registryCredential = 'dockerhub'
    dockerImage = ""
    clusterName = "capstoneProject"

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
        dockerImage = docker.build(registry)
        sh "docker image ls"
        
    }

    stage('Push blue image') {
        docker.withRegistry( '', registryCredential ) {
            dockerImage.push(versionTag)
        }
    }

    stage('Verify/Create Cluster'){
        withAWS(region:'us-west-1', credentials:'demo-ecr-credentials') {
        def resp = sh(returnStdout: true, script: "aws eks list-clusters").trim()
        def j = readJSON text: resp
        def clusterFound = false
        for (cluster in j['clusters']){
            if (cluster == clusterName){
                sh "echo 'Cluster already exists!'"
                clusterFound = true
            }
        }
        if (!clusterFound){
            sh "echo 'Start cluster deployment'"
            sh "eksctl create cluster --name $clusterName --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 3 --managed"
        }
    }
        

    }

    stage('create the kubeconfig file') {
        withAWS(region:'us-west-1', credentials:'demo-ecr-credentials') {
        sh """
            aws eks --region us-west-1 update-kubeconfig --name $clusterName
        """
    } 
    }

    stage('Deploy blue container') {
        withAWS(region:'us-west-1', credentials:'demo-ecr-credentials') {
        sh """
            kubectl apply -f service-deployment.yml
            kubectl get pods
            kubectl get services
        """
    } 
    }

    stage('Redirect service to blue container') {
        sh'echo Redirect service to blue container' 
    }    
}
