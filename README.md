# Microservice-Deployment-Jenkins

Example Project to show how to deploy a microservice using Kubernetes on AWS. For this example I used a simple flask application with a ML model to predict house prices base in some parameters.

## Infrastructure

For infrastructure, I used EKS in order to deploy Kubernetes cluster on AWS. One step in Jenkins pipeline makes sure that there is a cluster deployed if not it will create a cluster using eksctl which is a command-line tool that simplifies the cluster creation, so it not only creates the cluster but all other services required like VPC, IAM Roles , Segurity groups and so on. For more information on eksctl see [docs](https://eksctl.io/introduction/).

## CI/CD

For Continuous Delivery I configured a jenkins server using an EC2 instance. For more information on how to make this configuration plese refer to this [link](https://medium.com/@andresaaap/how-to-install-docker-aws-cli-eksctl-kubectl-for-jenkins-in-linux-ubuntu-18-04-3e3c4ceeb71). have in mind that Besides jenkins server configuration, some extra plugins are needed. You may noticed that repo contains two branches so a multibranch pipeline is required in order to run jenkins. The steps executed in jenkins are:

- Preparation(Checkout repo)
- Initialization (Set some variables depending on current branch)
- Linting (make linting using hadolint)
- Build image (Build docker image described in Dockerfile)
- Push image (Push the image to dockerhub)
- Verify/Create Cluster (Cheks if there is a cluster already deployed if not it creates one)
- create the kubeconfig file (creates kubeconfig file in order to interact with clusterAPI using kubectl)
- Deploy container (Create pods)
- Redirect service to green container (update load balancer to use deployed service)

## Deployment Strategy

For deployment strategy I used blue-green deployment where the feature branch(develop) creates a blue deployment and main branch create a green deployment.For better idea on how to implement this deployment strategy refer to this [article](https://medium.com/@andresaaap/simple-blue-green-deployment-in-kubernetes-using-minikube-b88907b2e267).

## Tech Stack

Some of the technologies used here are:

- Python
- Flask
- hadolint
- Docker
- Kubernetes
- EKS
- Jenkins
- eksctl

## Final Notes

This repo demostrates a simple example of microservice deployment for learning purposes, in a real world scenario we'll need to use a more personalized cluster configuration and also more steps in our jenkins file. As a good practice have in mind use minikube locally in order to try out your microservice as it is easiest to debug it.
