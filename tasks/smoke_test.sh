#!/usr/bin/env bash
# MOCK: run an app-specific smoke test. A real suite would hit ${PT_endpoint}
# and exit non-zero on failure so a workflow validation gate can halt the rollout.
set -euo pipefail
ENDPOINT="${PT_endpoint:-http://localhost:8080}"
SUITE="${PT_suite:-core}"
echo "running '${SUITE}' smoke test against ${ENDPOINT} on $(hostname)..." >&2
sleep 1
printf '{"status":"passed","node":"%s","suite":"%s","endpoint":"%s","passed":12,"failed":0}\n' \
  "$(hostname)" "${SUITE}" "${ENDPOINT}"
