#!/usr/bin/env bash
# Check cards before registering: offline schema + HEP-convention validation, then the template-diff check.
#   scripts/check.sh [CARD.md ...]          (default: every card under cards/)
# PYTHON: a python with pyyaml + jsonschema (environment.yml / requirements.txt). DISCOVERY_LOCAL_DIR: optional,
# enables discovery-local's check_card.py (defaults to ${DISCOVERY_LOCAL_DIR}).
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
py="${PYTHON:-python3}"
"$py" "$here/scripts/validate.py" "$@"
dl="${DISCOVERY_LOCAL_DIR:-${DISCOVERY_LOCAL_DIR}}"
if [[ -f "$dl/templates/check_card.py" && $# -gt 0 ]]; then
  for c in "$@"; do "$py" "$dl/templates/check_card.py" "$c"; done
fi
