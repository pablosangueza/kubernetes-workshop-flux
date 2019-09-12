# kubernetes-workshop-flux

This repo contains a basic example of how flux can be used to deploy kubernetes workloads.

## Setup your minikube instance with flux

1. Fork this repo into your own github (click the fork button at the top right of this page)
1. Clone this repo on to your workstation (replace `jwenz723` with your username): `git clone https://github.com/jwenz723/kubernetes-workshop-flux.git`
1. cd into [scripts](/scripts) 
1. Install tiller into your cluster by running `helm init --wait`.  Tiller is the server-side component that helm interacts with.
1. execute the script for your OS
    (before you execute the script modify `git@github.com:jwenz723/kubernetes-workshop-flux` to replace `jwenz723` with your github username)
    * windows: [flux-init.bat](/scripts/flux-init.bat)
    * linux/mac: [flux-init.sh](/scripts/flux-init.sh)
1. Copy the ssh public key that is printed when the script finishes (should start with `ssh-rsa`)
1. Browse to (replace `jwenz723` with your username) https://github.com/jwenz723/kubernetes-workshop-flux/settings/keys/new to create a new deploy key
1. Set the title to 'kubernetes-workshop'
1. Set the key value to the ssh key you copied earlier
1. Check the box 'Allow write access' to allow flux to commit back to the repo
1. Click Add Key
1. Watch the flux logs to see if it is working using the command: `kubectl logs -n flux -l app=flux -f`

## Modify the deployment

Assuming that you made some changes to the [apps](https://github.com/jwenz723/kubernetes-workshop-demohttp), you should
make changes in this repo to make use of your newly created docker images.

1. Modify [backend-dep.yaml](/k8s/backend-dep.yaml) to point at your docker image (change this line: `image: jwenz723/demohttp-backend:flux-sync-3-gd84c559-dirty`)
1. Modify [frontend-dep.yaml](/k8s/frontend-dep.yaml) to point at your docker image (change this line: `image: jwenz723/demohttp-frontend:flux-sync-3-gd84c559-dirty`)
1. Make a new git commit and push your changes up to github:
    
    ```bash
   git add .
   git commit -m "updated docker image path"
   git push origin master 
   ```
   
1. Now watch your minikube cluster to see your new image deployed: `kubectl get pods -w` (you should see the `AGE` value 
in the right column drop to a value less than 10s when your new pod is created)


## Feeling adventurous?

Try adding a deployment of your application of choice into the repo and have it deployed through flux. You can define yaml
files for your deployment within the [k8s](/k8s) directory following the pattern of what is already defined there.

