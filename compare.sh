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

for system in "hexane" "kerosene" "ender"; do
  echo "Comparing NixOS configuration for $system"
  current=$(nix build .#nixosConfigurations.$system.config.system.build.toplevel --print-out-paths --no-link 2> >(gray_stderr))
  nvd diff "roots/nixos/$system" "$current"
done

for system in "hexane" "kerosene"; do
  echo "Comparing Home Manager configuration for $system"
  current=$(nix build .#homemanagerConfigurations.$system.activationPackage --print-out-paths --no-link 2> >(gray_stderr))
  nvd diff "./roots/hm/$system" "$current"
done
