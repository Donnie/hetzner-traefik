# hetzner-traefik

This is a simple setup to run minikube on a Hetzner VM.

* Choice of Ingress controller is Traefik Proxy
* Using a helm chart to set up a full stack app
* The app depends on the values of configmaps and secrets, therefore it necessary that they restart when the values in those objects change
* Caddy handles the reverseproxy from minikube and also autorenews the TLS certificate
* You can do the TLS management with cert-manager on GKE, EKS, however, the cost would not be justified

## Setup

### Hetzner

Start up a new VM on Hetzner, preferably with 4GB mem

### Doman registrar / DNS table

Set up an A record pointing your domain name to the Hetzner VM IP

### Run the scripts like 1, 2, 3.

SSH into your VM, and `git clone` this repo on the VM like so:

```
  - git clone https://github.com/Donnie/hetzner-traefik.git
```

`cd` to `scripts` directory inside the repo.

1. First run `./1-init.sh`
This will install all the necessary tools for the project.

2. Then run `./2-deploy.sh`
This will install the demo chart and output the local URL for the app.

3. Then `./3-caddy.sh your.domain.com`
This will add the TLS certificate to the setup and make it available on your domain.

Now do `curl https://your.domain.com`

### Maintenance and Updates

1. Make changes to the chart templates or values.
2. Simply run `./2-deploy.sh` only

This would update the app even if there are secret or configmap changes.

### Features

The scripts are setup in an idempotent way, you can run them as many times.

### Cleanup

The app along with Minikube can be cleaned up by just running `./cleanup.sh`
