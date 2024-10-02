# edge
Provision fully managed Amazon Elastic Kubernetes Service (AWS EKS) in a multi environment for development

Use Amazon EKS to manage and automate the testing and deployment of container workloads

1. The development team commits code to Bitbucket Repository
2. Code scan, code quality and code coverage will be integrated in bamboo using tools like pylint, SonarQube, AppScan. 
3. Use Bamboo build tools, eg Maven and Docker , this will build the container image 
4. Use Bamboo build tools, eg  Docker , this will push the container image to Container Registry eg AWS ECR
5. Use Bamboo build tools, eg  Helm, this will pull the container image from  the Container Registry, and update the helm version
6. Use Bamboo build tools, eg  Helm, to package and push helm chart to helm repository eg AWS ECR
7.  Use Bamboo deployment agent  tools such as helm to update the image tag for the deployment  
8. Use Bamboo deployment agent  tools  such as helm to deploy the application from the current directory into the Kubernetes cluster. helm will perform a rolling update of the pods as specified in docker image.



Steps in Bamboo build/ test CI
Define variables in the plan configuration

CD
create trigger, notification if needed 
Define variable 

AWS_ACCOUNT_ID
AWS_REGION
DOCKER_ECR_REPO :
PACKAGE_NAME : *.tgz
PACKAGE_PATH : pkg/helm/

Task
 Source Code Checkout
Task 2
 Docker Build- docker
  Repository: ${bamboo.AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${bamboo.DOCKER_ECR_REPO}:${bamboo.buildNumber}
  use Dockerfile located in context path
Task 3 - script
 Docker Push Image to ECR
  This has to be incline,copy and paste inline script is in ./script/docker-ecr.sh
Task 4 - script
  make helm-pack-script executable 
    chmod +x ./scripts/helm-pack.sh
Task 5 - script
  update helm release version
    inline script.. located in ./script/update-helm-version.sh
Task 6 - script
   package helm chart
    inline script.. located in ./script/helm-pack.sh
Task 7- script
  Make helm package script executable
    chmod 777 ./pkg/helm/*.tgz
Task 8- script
  push helm chart to ECR
    inline script located in ./scripts/publish-helm-ecr.sh


CD
create trigger, notification if needed 
Define variable 
AWS_ACCESS_KEY_ID
AWS_ACCOUNT_ID
AWS_REGION
AWS_SECRET_ACCESS_KEY
ECR_REPOSITORY_NAME
EKS_CLUSTER_NAME

Task 1
  Source Code Checkout

Task 2
  Script 
  Deploy to Dev authomatically 
  inline script , code is in ./script/deploy.sh

