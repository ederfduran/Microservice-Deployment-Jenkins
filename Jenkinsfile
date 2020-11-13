node{
    deploymentColor = ""
    deploymentFile = ""
    registry = "ederd/flaskapp"
    versionTag = "v0.0.1"
    registryCredential = 'dockerhub'
    dockerImage = ""
    clusterName = "capstoneProject"

    stage('Preparation'){
        checkout scm
        sh 'git rev-parse --short HEAD'
        sh 'pwd' 
    }

    stage('Initialization'){
        if (env.BRANCH_NAME == "main"){
            deploymentColor = "green"
            deploymentFile = "service-green-deployment.yml"
        } else{
            deploymentColor = "blue"
            deploymentFile = "service-blue-deployment.yml"
        }
        echo "Deployment Color ${deploymentColor}"
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

    stage('Build image') {
        dockerImage = docker.build(registry+deploymentColor)
        sh "docker image ls"
        
    }

    stage('Push image') {
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
            kubectl apply -f $deploymentFile
            kubectl get pods
            kubectl get services
        """
    } 
    }

    stage('Redirect service to green container') {
        if (deploymentColor == "green"){
        sh """
            echo 'Redirect service to blue container'
            kubectl apply -f blue-green-service.yml
        """
        }
    }

    stage('smoke test'){
        withAWS(region:'us-west-1', credentials:'demo-ecr-credentials') {
        def resp = sh(returnStdout: true, script: "kubectl get svc flaskapp-service -o json").trim()
        def j = readJSON text: resp
        sh "echo ${j}"
        HOST = j['status']['loadBalancer']['ingress'][0]['hostname']
        PORT = 80
        ./make_prediction.sh
    } 
    }   
}
