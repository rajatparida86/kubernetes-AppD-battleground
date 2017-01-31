=======
# Kubernetes-AppD-battleground
Appdynamics agent integration for applications deployed on Kubernetes
Use the appropriate docker image containing a AppD python agent (e.g. rajatparida86/appdynpythonmonitor)

##Start up a Kubernetes multi node cluster from the coreos vagrant image from [here](https://coreos.com/kubernetes/docs/latest/kubernetes-on-vagrant.html)

##Build the application docker image with appropriate controller configuration from existing Python source code and push it to Docker Hub. Replace DOCKER_HUB_USER with your Docker Hub username.
```
cd Docker
docker build . -t <DOCKER_HUB_USER>/sample-redis-talker
docker push <DOCKER_HUB_USER>/sample-redis-talker
```

##Build the machine agent docker image with appropriate controller configuration and push it to Docker Hub. Replace DOCKER_HUB_USER with your Docker Hub username.
```
cd k8-machineagent
docker build . -t <DOCKER_HUB_USER>/kubernetes-appdynmachineagent
docker push <DOCKER_HUB_USER>/kubernetes-appdynmachineagent
cd ../
```

##Create pod for redis
```
cd Kubernetes
kubectl create -f db-pod.yml
```

##Create service for redis
```
kubectl create -f db-svc.yml
```

##Create pod for web
```
kubectl create -f web-pod.yml
```

##Create service for web
```
kubectl create -f web-svc.yml
```

##Create daemonset for machine agent
```
kubectl create -f machineagentdaemonset.yml
```

##Put load on the redis based python application
kubectl get nodes
##Example:
        NAME           STATUS                     AGE
        172.17.4.101   Ready,SchedulingDisabled   3h
        172.17.4.201   Ready                      3h
        kubectl describe svc web

kubectl describe svc web
##Example:
        Name:			web
        Namespace:		default
        Labels:			app=demo
            name=web
        Selector:		name=web
        Type:			NodePort
        IP:			10.3.0.176
        Port:			<unset>	80/TCP
        NodePort:		<unset>	30239/TCP
        Endpoints:		10.2.71.10:5000
        Session Affinity:	None
        No events.
##Access the application:
curl <node IP>:<service nodeport>
##Example: (Based on above values)
curl 172.17.4.201:30239

##Check the controller to se the Application reporting and correlation between the python app agent and the machine agent
