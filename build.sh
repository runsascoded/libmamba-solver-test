#!/usr/bin/env bash

set -e

usage() {
    echo "Usage: $0 <install-conda|install-mamba-cli|install-mamba-solver>" >&2
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi
IMG="$1"; shift

args=()

case "$IMG" in
    install-mamba-cli) BIN=mamba ;;
    install-mamba-solver) BIN=conda ;;
    install-conda) ;;
    *) usage ;;
esac

set -x
docker build -t$IMG -f $IMG.dockerfile .

if [ "$IMG" == install-mamba-cli ]; then
    time docker build -t$env-update:mamba-cli -f env-update.dockerfile --build-arg FROM=install-mamba-cli .
elif [ "$IMG" == install-mamba-cli ]; then
    time docker build -t$env-update:mamba-solver -f env-update.dockerfile --build-arg FROM=install-mamba-solver .
fi
