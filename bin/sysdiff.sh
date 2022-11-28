#!/usr/bin/env nix-shell
#! nix-shell -i bash -p fd entr nvd

# shellcheck shell=bash

set -euo pipefail
IFS=$'\n\t'
export SHELL=`which bash`

function usage() {
    cat <<EOF
Usage: ${0} <host>

Watch for any changes between the flake nixosConfiguration for <host> at time
of invocation versus subsequent writes to the flake and its related files.

Example use:

        ${0} <host>

The command watches until terminated with Ctrl-C or the `q` key.
EOF
}

function spin() {
    while :;do for s in / - \\ \|; do printf "\r$s ...building...";sleep 0.2;done;done
}

if [[ $# -lt 1 ]]
then
    usage
    exit 1
else
    system=$1 ; shift
fi

function drv() {
    nix --no-warn-dirty path-info --derivation \
        ".#nixosConfigurations.${1}.config.system.build.toplevel"
}

original=$(drv ${system})

function drvdiff() {
    clear
    spin &
    spinner=$!
    revised=$(drv ${system})
    kill $spinner
    if [[ $original == $revised ]]
    then
        echo "✅ Identical"
    else
        nvd diff ${original} ${revised}
    fi
}

export original system
export -f drv drvdiff spin

echo "Entering watch. Hit q to exit loop"
fd | entr -s drvdiff
