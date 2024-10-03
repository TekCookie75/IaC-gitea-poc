#!/bin/bash

if command -v butane 2>&1 >/dev/null
then
    echo "Local Installation of butane found"
    echo "Running butane to generate ignition file"
    butane --pretty --strict --files-dir=./ ./Fedora-CoreOS.yml --output Fedora-CoreOS.ign
    exit 0
fi

if command -v podman 2>&1 >/dev/null
then
    echo "Podman found!"
    echo "Running butane from inside container to generate ignition file"
    podman run \
        --interactive \
        --rm \
        --security-opt label=disable \
        --volume ${PWD}:/pwd \
        --workdir /pwd quay.io/coreos/butane:release \
        --pretty \
        --strict Fedora-CoreOS.yaml > Fedora-CoreOS.ign
    exit 0
fi

echo "This script require Butane or podman. Make sure to install one of these requirements!"
exit 1
