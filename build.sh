#!/usr/bin/env bash

set -e

usage() {
    echo "Usage: $0 <install-conda|install-mamba|mamba-solver> [conda version]" >&2
    exit 1
}
if [ $# -eq 0 ]; then
    usage
fi
IMG="$1"; shift
if [ $# -eq 0 ]; then
    case "$IMG" in
        install-mamba) CONDA=4.12.0 ;;
        mamba-solver) CONDA=23.3.1-0 ;;
        *) usage ;;
    esac
elif [ $# -eq 1 ]; then
    CONDA="$1"; shift
else
    usage
fi

set -x
docker build -t$IMG:$CONDA -f $IMG.dockerfile --build-arg CONDA=$CONDA .
