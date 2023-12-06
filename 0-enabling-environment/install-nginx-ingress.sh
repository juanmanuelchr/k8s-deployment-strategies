# Azure Login
az login --service-principal -u 7709f2bd-6bbb-4987-85c0-7289b7a2995e \
-p ~/workspace/SVPRCTPLAPPDES03_full.pem \
--tenant 5d93ebcc-f769-4380-8b7e-289fc972da1b

# Set Azure subscription
az account set --subscription 2306ee5e-2d98-4111-ac76-a31ab1c2c328

# Azure AKS Get Credentials
az aks get-credentials --resource-group rg-aks-jm --name aks-jm --admin

# Create the NGINX Ingress Controller with Basic Configuration
NAMESPACE=ingress-nginx

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

# Check external IP for Ingress Controller (provided by Azure Load Balancer)
kubectl get services --namespace $NAMESPACE -o wide -w ingress-nginx-controller