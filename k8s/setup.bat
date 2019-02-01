
rem cleanup previous instalations
kubectl delete services healthylinkx-ux-service
kubectl delete deployments healthylinkx-ux-deployment

IF "%1"=="CLEAN" exit /B 0

rem mount the directory
minikube mount %~dp0..:/mnt/healthylinkx-ux

rem create the containers
minikube ssh /mnt/healthylinkx-ux/docker/container.sh BUILD

exit /b 0

rem create new resources
kubectl create -f %~dp0.\ux-service.yaml
kubectl create -f %~dp0.\ux-deployment.yaml

exit /B 0
