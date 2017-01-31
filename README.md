=======
# kubernetes-AppD-battleground
Appdynamics agent integration for applications deployed on Kubernetes
>>>>>>> d8744a559a1de2966282acd39e3dc407241da916
<<<<<<< HEAD
Use the appropriate docker image containing a AppD python agent (e.g. rajatparida86/appdynpythonmonitor)

- Start up a Kubernetes multi node cluster from the coreos vagrant image from [here](https://coreos.com/kubernetes/docs/latest/kubernetes-on-vagrant.html)
- Create pods for redis
- Create service for redis
- Create pods for web
- Create service for web
- Create daemonset for machine agent



# kubernetes
Tutorial to build and deploy a simple Python app in Kubernetes. The walkthrough is available [here](https://youtu.be/zeS6OyDoy78).

Make sure that you have access to a Kubernetes cluster.

## Build a Docker image from existing Python source code and push it to Docker Hub. Replace DOCKER_HUB_USER with your Docker Hub username.
```
cd Docker
docker build . -t <DOCKER_HUB_USER>/web
docker push <DOCKER_HUB_USER>/web
```

## Launch the app with Docker Compose
```
docker-compose up -d
```

## Test the app
```
curl localhost:3000
```

## Deploy the app to Kubernetes
```
cd ../Kubernetes
kubectl create -f db-pod.yml
kubectl create -f db-svc.yml
kubectl create -f web-pod.yml
kubectl create -f web-svc.yml
kubectl create -f web-rc.yml
```

## Check that the Pods and Services are created
```
kubectl get pods
kubectl get svc
```

## Get the NodePort for the web Service. Make a note of the port.
```
kubectl describe svc web
```

## Test the app by accessing the NodePort of one of the nodes.

```
kubectl get nodes
curl <NODE_IP>:<NODEPORT>
```
