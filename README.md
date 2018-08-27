healthylinkx-ux
===============
Healthylinkx is a 3 tiers app: ux, api and datastore. Healthylinkx creates and runs a container for each tier.

This repo implements the ux tier in a single page web app using bootstrap and jquery. It is a container running apache.

Directories:\
Src. the code of the app. index.html has the web page and bootstrap code. js/clientcode.js contains the javascript code specific to this app. To note that at the top of this file it is declared the URL to the api and you might need to edit it.\
vm. files to setup a vm using vagrant and virtualbox. move the vagrantfile to the root of the repo.\
docker. how to create and manage the container.\
k8s. templates to create the service in kubernetes. tested with minikube.\

