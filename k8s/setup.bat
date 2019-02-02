
rem mount the directory
rem there is a bug https://github.com/kubernetes/minikube/issues/2442
rem start minikube mount --ip 192.168.99.1 %~dp0..:/mnt/healthylinkx-ux

rem as mount doesn't work (it does as root) we use a link
minikube ssh "ln -s /c/Users/Mauricio/Documents/healthylinkx-ux /home/docker/healthylinkx-ux"

rem create the containers
minikube ssh "/home/docker/healthylinkx-ux/docker/container.sh BUILD"

rem create resources
kubectl create -f %~dp0.\ux-service.yaml
kubectl create -f %~dp0.\ux-deployment.yaml

exit /B 0
