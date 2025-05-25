#!/bin/bash

# Check if domain argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    echo "Example: $0 your.domain.com"
    exit 1
fi

DOMAIN="$1"

# Create Caddyfile for reverse proxy with automatic HTTPS
cat > /etc/caddy/Caddyfile << EOF
$DOMAIN {
	reverse_proxy http://$(minikube ip):30080
}
EOF

service caddy start
caddy reload --config /etc/caddy/Caddyfile
