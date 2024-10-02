#so because we are using bamboo variables this has to be inline, wont work with file.
# #!/bin/bash

# Set AWS region and ECR repository information
AWS_REGION="${bamboo.AWS_REGION}"
AWS_ACCOUNT_ID="${bamboo.AWS_ACCOUNT_ID}"
DOCKER_ECR_REPO="${bamboo.DOCKER_ECR_REPO}"
BUILD_NUMBER="${bamboo.buildNumber}"

# Authenticate Docker with ECR
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$DOCKER_ECR_REPO"

# Build and tag Docker image
#docker build -t "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$DOCKER_ECR_REPO:$BUILD_NUMBER" .

# Push Docker image to ECR
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$DOCKER_ECR_REPO:$BUILD_NUMBER"