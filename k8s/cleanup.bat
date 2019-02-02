
rem cleanup resources
kubectl delete services healthylinkx-ux-service
kubectl delete deployments healthylinkx-ux-deployment

rem cleanup the container image
minikube ssh "/home/docker/healthylinkx-ux/docker/container.sh CLEANUP"

rem remove link
minikube ssh "rm /home/docker/healthylinkx-ux"

exit /b 0
