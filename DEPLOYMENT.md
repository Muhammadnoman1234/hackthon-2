# TaskFlow AI - Kubernetes Deployment Guide

## Prerequisites

- Docker Desktop with Kubernetes enabled, OR
- Minikube installed
- kubectl installed
- Helm 3.x installed

## Quick Start with Docker Compose (Local Development)

```bash
# Build and start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

Access the application:
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs

## Kubernetes Deployment (Minikube)

### 1. Start Minikube

```bash
minikube start --cpus=4 --memory=8192
minikube addons enable ingress
```

### 2. Build Docker Images

```bash
# Build frontend
cd frontend
docker build -t taskflow/frontend:latest .

# Build backend
cd ../backend
docker build -t taskflow/backend:latest .

# Load images into Minikube
minikube image load taskflow/frontend:latest
minikube image load taskflow/backend:latest
```

### 3. Deploy with Helm

```bash
# Add Bitnami repository for PostgreSQL
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Install the application
cd ..
helm install taskflow ./helm

# Check deployment status
kubectl get pods
kubectl get services
kubectl get ingress
```

### 4. Access the Application

```bash
# Get Minikube IP
minikube ip

# Add to /etc/hosts (or C:\Windows\System32\drivers\etc\hosts on Windows)
# <minikube-ip> taskflow.local

# Access at: http://taskflow.local
```

## Production Deployment (Cloud)

### DigitalOcean Kubernetes (DOKS)

```bash
# Connect to your DOKS cluster
doctl kubernetes cluster kubeconfig save <cluster-name>

# Update values for production
helm install taskflow ./helm \
  --set ingress.hosts[0].host=taskflow.yourdomain.com \
  --set env.backend.BETTER_AUTH_SECRET=<your-secret> \
  --set env.backend.OPENAI_API_KEY=<your-key> \
  --set postgresql.auth.password=<strong-password>
```

### Azure Kubernetes Service (AKS)

```bash
# Connect to AKS
az aks get-credentials --resource-group <rg> --name <cluster>

# Deploy
helm install taskflow ./helm -f helm/values-azure.yaml
```

## Monitoring and Maintenance

### View Logs

```bash
# Frontend logs
kubectl logs -l app.kubernetes.io/component=frontend -f

# Backend logs
kubectl logs -l app.kubernetes.io/component=backend -f

# Database logs
kubectl logs -l app.kubernetes.io/name=postgresql -f
```

### Scale Deployment

```bash
# Scale frontend
kubectl scale deployment taskflow-frontend --replicas=3

# Scale backend
kubectl scale deployment taskflow-backend --replicas=3
```

### Update Application

```bash
# Update Helm deployment
helm upgrade taskflow ./helm

# Rollback if needed
helm rollback taskflow
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods
kubectl describe pod <pod-name>
```

### Check Service Endpoints

```bash
kubectl get endpoints
```

### Access Pod Shell

```bash
kubectl exec -it <pod-name> -- /bin/sh
```

### Database Connection

```bash
# Port forward to PostgreSQL
kubectl port-forward svc/taskflow-postgresql 5432:5432

# Connect with psql
psql -h localhost -U taskflow -d taskflow
```

## Cleanup

```bash
# Uninstall Helm release
helm uninstall taskflow

# Stop Minikube
minikube stop

# Delete Minikube cluster
minikube delete
```
