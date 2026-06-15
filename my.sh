#!/usr/bin/env bash
set -euo pipefail

SING_BOX=${SING_BOX:-/root/sing-box}

to_rules() {
  local json=$1

  jq -r '
    def values($key):
      if has($key) then .[$key][] else empty end;

    (.rules // [])[]
    | (
        values("domain") | "DOMAIN," + .
      ),
      (
        values("domain_suffix") | "DOMAIN-SUFFIX," + .
      ),
      (
        values("domain_keyword") | "DOMAIN-KEYWORD," + .
      ),
      (
        values("ip_cidr") | "IP-CIDR," + .
      ),
      (
        values("process_name") | "PROCESS-NAME," + .
      )
  ' "$json"
}

for json in ./*.json; do
  [ -e "$json" ] || continue

  stem=${json%.json}

  "$SING_BOX" rule-set compile "$json"

  to_rules "$json" > "${stem}.list"

  {
    if rules=$(to_rules "$json"); [ -n "$rules" ]; then
      printf 'payload:\n'
      printf '%s\n' "$rules" | jq -Rr '"  - " + @json'
    else
      printf 'payload: []\n'
    fi
  } > "${stem}.yaml"
done
