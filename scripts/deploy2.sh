#!/bin/bash

# Authenticate with the EKS cluster
aws eks update-kubeconfig --name bws-cluster --region us-east-1
whoami


kubectl get ns

