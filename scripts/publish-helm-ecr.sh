#!/bin/bash
# this must be inline because of the bamboo variables

# Set your Helm chart details
AWS_REGION="${bamboo.AWS_REGION}"
AWS_ACCOUNT_ID="${bamboo.AWS_ACCOUNT_ID}"
PACKAGE_PATH="${bamboo.PACKAGE_PATH}"
PACKAGE_NAME="${bamboo.PACKAGE_NAME}"


# Authenticate Docker to the ECR registry
#aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com


#Authenticate helm to the ECR registry
aws ecr get-login-password --region ${AWS_REGION} | helm registry login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

#push helm chart to AWS-ECR
helm push ${PACKAGE_PATH}/${PACKAGE_NAME} oci://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com