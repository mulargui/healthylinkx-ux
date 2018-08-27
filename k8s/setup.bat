
rem cleanup previous instalations
kubectl delete services healthylinkx-ux-service
kubectl delete deployments healthylinkx-ux-deployment

IF "%1"=="CLEAN" exit /B 0

rem create the containers
minikube ssh /c/Users/mulargui/cluster/healthylinkx-ux/docker/container.sh BUILD

rem create new resources
kubectl create -f %userprofile%/cluster/healthylinkx-ux/k8s/ux-service.yaml
kubectl create -f %userprofile%/cluster/healthylinkx-ux/k8s/ux-deployment.yaml

exit /B 0
