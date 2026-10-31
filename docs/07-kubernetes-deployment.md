# 07 — Kubernetes Deployment Baseline

This is a deployment baseline for the approved image. It is not evidence that a Kubernetes deployment has already been completed.

## Before deployment

- Ensure the image has passed the team's configured security gate.
- Prefer an immutable image digest over a mutable tag.
- Confirm registry authentication for the cluster.
- Ensure the cluster has appropriate network policies, RBAC, resource limits, and runtime controls.

## Deployment manifest

Replace `YOUR_JFROG_DOCKER_REGISTRY` and the image digest with actual values. Do not deploy the placeholder image reference.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-api
  namespace: production
  labels:
    app.kubernetes.io/name: secure-api
spec:
  replicas: 2
  selector:
    matchLabels:
      app.kubernetes.io/name: secure-api
  template:
    metadata:
      labels:
        app.kubernetes.io/name: secure-api
    spec:
      containers:
        - name: secure-api
          image: YOUR_JFROG_DOCKER_REGISTRY/foma-docker-local/secure-api@sha256:REPLACE_WITH_VERIFIED_DIGEST
          ports:
            - name: http
              containerPort: 5000
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            capabilities:
              drop:
                - ALL
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 500m
              memory: 256Mi
          readinessProbe:
            httpGet:
              path: /health
              port: http
          livenessProbe:
            httpGet:
              path: /health
              port: http
---
apiVersion: v1
kind: Service
metadata:
  name: secure-api
  namespace: production
spec:
  selector:
    app.kubernetes.io/name: secure-api
  ports:
    - name: http
      port: 80
      targetPort: http
  type: ClusterIP
```

## Apply and inspect

```bash
kubectl create namespace production
kubectl apply -f k8s/secure-api.yaml
kubectl rollout status deployment/secure-api -n production
kubectl get pods -n production -o wide
kubectl get svc -n production
```

The read-only root filesystem may require a writable temporary volume if the application or runtime needs to write files. Validate this setting in a test namespace before production.

## Image trust

For stronger supply-chain assurance, sign approved images and verify signatures at admission time. Signing proves identity/integrity relative to a trusted signer; it does not prove an image is vulnerability-free.
