# hetzner-traefik

This is a simple setup to run minikube on a Hetzner VM.

Choice of Ingress controller is Traefik Proxy.

Using a helm chart to set up a full stack app.

The app depends on the values of configmaps and secrets, therefore it necessary that they restart when the values in those objects change.

Caddy handles the reverseproxy from minikube and also autorenews the TLS certificate.

You can do the TLS management with cert-manager on GKE, EKS, however, the cost would not be justified.
