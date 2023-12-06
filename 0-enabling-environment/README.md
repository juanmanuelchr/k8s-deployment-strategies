# Create and empty AKS cluster in Azure

# Create the NGINX Ingress Controller with Basic Configuration

1. Set the namespace name
```bash
NAMESPACE=ingress-basic
```
2. With Helm, we will install NGINX Ingress Controller using the last updated chart

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz
```

3. Check external IP for Ingress Controller (provided by Azure Load Balancer)

```bash
kubectl get services --namespace ingress-basic -o wide -w ingress-nginx-controller

NAME                       TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE   SELECTOR
ingress-nginx-controller   LoadBalancer   10.0.65.205   EXTERNAL-IP     80:30957/TCP,443:32414/TCP   1m   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
```