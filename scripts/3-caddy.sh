#!/bin/bash

# Create Caddyfile for reverse proxy with automatic HTTPS
cat > /etc/caddy/Caddyfile << EOF
traefik.donnie.in {
	reverse_proxy http://$(minikube ip):30080
}
EOF

service caddy start
caddy reload --config /etc/caddy/Caddyfile
