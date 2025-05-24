#!/bin/bash

# Start minikube cluster if not already running
echo "Starting minikube cluster with podman driver (CPUs=4, Memory=6GB)..."
if ! minikube status | grep -q "Running"; then
    minikube start --driver=podman --force --cpus=4 --memory=6g
fi

# Show available namespaces
echo "Available namespaces:"
kubectl get namespaces

NAMESPACE="traefik"
if ! kubectl get namespace "$NAMESPACE" &> /dev/null; then
    echo "Creating namespace $NAMESPACE..."
    kubectl create namespace "$NAMESPACE"
fi

# Apply helm chart
echo "Installing the chart"
helm repo add traefik https://helm.traefik.io/traefik
helm dependency build ../chart
helm upgrade --install traef ../chart -n "$NAMESPACE"

# Wait for the deployment to be ready
echo "Waiting for deployment to be ready..."
kubectl rollout status deployment/nginx -n "$NAMESPACE"
kubectl rollout status deployment/traef-traefik -n "$NAMESPACE"

# Get the service URL
echo "Your application is available at http://$(minikube ip):30080"
