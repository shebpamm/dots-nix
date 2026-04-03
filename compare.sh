#!/usr/bin/env nix
#!nix shell nixpkgs#nvd -c bash

gray_stderr() {
  awk '{
    # Remove ANSI escape sequences
    gsub(/\033\[[0-9;]*m/, "")
    # Wrap in gray and reset
    print "\033[90m" $0 "\033[0m"
  }' >&2
}

hm() {
  system="$1"
  echo "Comparing Home Manager configuration for $system"
  current=$(nix build ".#homemanagerConfigurations.$system.activationPackage" --print-out-paths --no-link 2> >(gray_stderr))
  nvd diff "./roots/hm/$system" "$current"
}

nixos() {
  system="$1"
  echo "Comparing NixOS configuration for $system"
  current=$(nix build ".#nixosConfigurations.$system.config.system.build.toplevel" --print-out-paths --no-link 2> >(gray_stderr))
  nvd diff "roots/nixos/$system" "$current"
}

all() {
  for system in "hexane" "kerosene" "ender"; do
    nixos "$system"
  done

  for system in "hexane" "kerosene"; do
    hm "$system"
  done
}

# if no arguments are given, compare all systems
# otherwise, compare only the specified systems
# usage: compare.sh [nixos|hm] [system...]

if [[ "$1" == "nixos" ]]; then
  shift
  for system in "$@"; do
    nixos "$system"
  done
elif [[ "$1" == "hm" ]]; then
  shift
  for system in "$@"; do
    hm "$system"
  done
else
  all
fi
