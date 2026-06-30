#!/usr/bin/env bash
# MOCK: gracefully quiesce the finance app before patching.
set -euo pipefail
SVC="${PT_service:-finapp}"
DRAIN="${PT_drain_seconds:-20}"
echo "pausing scheduled jobs and draining ${SVC} for ${DRAIN}s on $(hostname)..." >&2
sleep 1
printf '{"status":"quiesced","node":"%s","service":"%s"}\n' "$(hostname)" "${SVC}"
