#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

/usr/bin/confd -onetime -backend env

use_staging_ca=${USE_STAGING_CA:-}

if [[ "$use_staging_ca" == "true" ]]; then
  use_staging_ca="-ca \"https://acme-staging-v02.api.letsencrypt.org/directory\""
else
  use_staging_ca=""
fi

execstr="/usr/bin/caddy $use_staging_ca -email $ISSUER_ADDRESS -agree -conf /etc/caddy/Caddyfile"

eval exec "$execstr"
