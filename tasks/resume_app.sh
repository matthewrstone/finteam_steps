#!/usr/bin/env bash
# MOCK: bring the finance app back up after patching.
set -euo pipefail
SVC="${PT_service:-finapp}"
echo "starting ${SVC} and resuming scheduled jobs on $(hostname)..." >&2
sleep 1
printf '{"status":"running","node":"%s","service":"%s"}\n' "$(hostname)" "${SVC}"
