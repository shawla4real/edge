pipeline {
    agent { 
        node {
            label 'docker-agent-alpine'
            }
    environment {
        AWS_REGION = "us-east-1"
        AWS_ACCOUNT_ID = "669813892999"
        EcrRegistryUrl = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        HELM_ECR_REPO = "${EcrRegistryUrl}/helm"
        AWS_ACCESS_KEY_ID = "AKIAZX5AE46D6VAVBXOX"
        AWS_SECRET_ACCESS_KEY = "BAMSCRT@0@0@K/amU2Cwt+wIUFtebbVFj12+ZptT/halRuCbIcwFOCpaY7gcKfOuREsunlofJHuI"
        Docker_Image_Name = "basecamp/docker"
        EKS_CLUSTER_NAME = "ecad-cluster"
        NAMESPACE = "bemo"
        PACKAGE_PATH = "pkg/helm/"
        PACKAGE_NAME = "*.tgz"
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
    triggers {
        pollSCM 'H/5 * * * *'
        }
            stage("Clone Code"){
            steps {
                echo "Cloning the code"
                git url:"https://github.com/LondheShubham153/django-notes-app.git", branch: "main"
            }
        }
    stage("Build"){
            steps {
                echo "Building the image"
                sh "docker build -t my-note-app ."
            }
        }
    // stages {
    //     stage('Build and Push Docker Image') {
    //         steps {
    //             script {
    //                 // Log in to AWS ECR
    //                 sh """
    //                     export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
    //                     export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
    //                     aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${EcrRegistryUrl}
    //                 """

    //                 // Build, Tag, and Push Docker Image
    //                 sh """
    //                     echo "Building Docker image"
    //                     docker build -t ${Docker_Image_Name}:${BUILD_NUMBER} .
    //                     echo "Tagging Docker image"
    //                     docker tag ${Docker_Image_Name}:${BUILD_NUMBER} ${EcrRegistryUrl}/${Docker_Image_Name}:${BUILD_NUMBER}
    //                     echo "Pushing Docker image to ECR"
    //                     docker push ${EcrRegistryUrl}/${Docker_Image_Name}:${BUILD_NUMBER}
    //                 """
    // //             }
    //         }
    //     }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                echo "doing test stuff.."
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo 'Deliver....'
                sh '''
                echo "doing delivery stuff.."
                '''
            }
        }
    }

