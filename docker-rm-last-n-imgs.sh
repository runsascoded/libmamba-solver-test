#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <image> <num>" >&2
    exit 1
fi
image="$1"; shift
num="$1"; shift

idx=0
img="$image"
while [ $idx -lt $num ]; do
    parent="$(docker inspect "$img" | jq -r '.[0].Parent')"
    docker rmi --no-prune "$img"
    img="$parent"
    let idx=idx+1
done
