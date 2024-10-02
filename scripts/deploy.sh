#!/bin/bash
# this must be inline because of the bamboo variables
# Set your AWS ECR details

AWS_ACCOUNT_ID="${bamboo.AWS_ACCOUNT_ID}"
ECR_REPOSITORY_NAME="${bamboo.ECR_REPOSITORY_NAME}"

# Define your EKS cluster and context name
EKS_CLUSTER_NAME="${bamboo.EKS_CLUSTER_NAME}"
AWS_REGION="${bamboo.AWS_REGION}"
AWS_ACCESS_KEY_ID="${bamboo.AWS_ACCESS_KEY_ID}"
AWS_SECRET_ACCESS_KEY="${bamboo.AWS_SECRET_ACCESS_KEY}"

# Set AWS environment variables
export AWS_DEFAULT_REGION=${AWS_REGION}
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

# Set your Helm chart details

BUILD_NUMBER="${bamboo.buildNumber}"
HELM_CHART_NAME=${ECR_REPOSITORY_NAME}
HELM_CHART_VERSION=${BUILD_NUMBER}
BUILD_NUMBER="${bamboo.buildNumber}"
version=$BUILD_NUMBER

# Authenticate with the EKS cluster
aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_REGION}

# Authenticate Helm to the ECR registry
aws ecr get-login-password --region ${AWS_REGION} | helm registry login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

sed -i "s/versionhere/$version/g" ./helm/Chart.yaml

helm template test --set image.tag=${HELM_CHART_VERSION}  --namespace bemo --create-namespace --version $version oci://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/helm-chart 
# Push Helm chart to ECR 
#use this to create repository if it does not exists
# aws ecr create-repository --repository-name ${ECR_REPOSITORY_NAME} --region ${AWS_REGION} 


helm upgrade --install --wait test --set image.tag=${HELM_CHART_VERSION}  --namespace bemo --create-namespace --version $version oci://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/helm-chart 

#The above will install package in eks