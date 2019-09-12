# kubernetes-workshop-flux

This repo contains a basic example of how flux can be used to deploy kubernetes workloads.

## Setup your minikube instance with flux

1. Fork this repo into your own github (click the fork button at the top right of this page)
1. Clone this repo on to your workstation (replace `jwenz723` with your username): `git clone https://github.com/jwenz723/kubernetes-workshop-flux.git`
1. cd into [scripts](/scripts) 
1. execute the script for your OS
    * windows: [flux-init.bat](/scripts/flux-init.bat)
    * linux/mac: [flux-init.sh](/scripts/flux-init.sh)
1. Copy the ssh public key that is printed when the script finishes (should start with `ssh-rsa`)
1. Browse to (replace `jwenz723` with your username) https://github.com/jwenz723/kubernetes-workshop-flux/settings/keys/new to create a new deploy key
1. Set the title to 'kubernetes-workshop'
1. Set the key value to the ssh key you copied earlier
1. Check the box 'Allow write access' to allow flux to commit back to the repo
1. Click Add Key
1. Watch the flux logs to see if it is working using the command: `kubectl logs -n flux -l app=flux -f`

## Add a helm chart into the deployment

