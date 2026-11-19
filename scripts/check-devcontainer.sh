#!/usr/bin/env bash
# Prints the environment and fails on the first broken expectation.
set -u
fail=0
check() { if eval "$2" >/dev/null 2>&1; then echo "ok    $1"; else echo "FAIL  $1"; fail=1; fi; }

echo "user=$(whoami) uid=$(id -u) arch=$(uname -m) os=$(. /etc/os-release; echo $PRETTY_NAME)"
echo "extras='${SYNC_EXTRAS:-}' python=$(python --version 2>&1) uv=$(uv --version 2>&1)"

check "running as nonroot"            '[ "$(whoami)" = nonroot ]'
check "x86_64 (lockfile platform)"    '[ "$(uname -m)" = x86_64 ]'
check "uv on PATH"                    'command -v uv'
check "git on PATH"                   'command -v git'
check "SYNC_EXTRAS set"               '[ -n "${SYNC_EXTRAS:-}" ]'
check "lockfile matches pyproject"    'uv lock --check'
check "venv in sync with lockfile"    'uv sync --locked --check ${SYNC_EXTRAS:-}'
check "venv owned by me"              '[ "$(stat -c %u .venv)" = "$(id -u)" ]'
check "workspace writable"            'touch .write-test && rm .write-test'
check "core, torch, import"   'python -c "import core, torch"'

exit $fail