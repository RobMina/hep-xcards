#!/usr/bin/env bash
# Check cards before registering: offline schema + HEP-convention validation, then the template-diff check.
#   scripts/check.sh [CARD.md ...]          (default: every card under cards/)
# PYTHON: a python with pyyaml + jsonschema (environment.yml / requirements.txt).
# DISCOVERY_LOCAL_DIR: optional path to a discovery-local checkout (enables templates/check_card.py).
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
py="${PYTHON:-python3}"
"$py" "$here/scripts/validate.py" "$@"
if [[ -n "${DISCOVERY_LOCAL_DIR:-}" && -f "$DISCOVERY_LOCAL_DIR/templates/check_card.py" && $# -gt 0 ]]; then
  for c in "$@"; do "$py" "$DISCOVERY_LOCAL_DIR/templates/check_card.py" "$c"; done
fi
