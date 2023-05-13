#!/usr/bin/env bash

set -e

usage() {
    echo "Usage: $0 <install-conda|install-mamba-cli|install-mamba-solver>" >&2
    echo "Usage: $0 env-update <cli|solver>" >&2
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi
IMG="$1"; shift

args=()
case "$IMG" in
    install-mamba-cli) BIN=mamba ;;
    install-mamba-solver) BIN=conda ;;
    install-conda) ;;
    env-update)
        if [ $# -ne 1 ]; then
            usage
        fi
        t="$1"; shift
        case "$t" in
            cli) CLI=mamba ;;
            solver) CLI=conda ;;
            *) usage ;;
        esac
        tag="mamba-$t"
        FROM="install-$tag"
        args=(--build-arg "FROM=$FROM" --build-arg "CLI=$CLI")
        ;;
    *) usage ;;
esac

if [ $# -gt 0 ]; then
    usage
fi

time docker build -t$IMG -f $IMG.dockerfile "${args[@]}" .
