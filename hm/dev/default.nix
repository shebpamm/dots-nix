{ config, pkgs, libs, ... }:
{
  imports = [
    ./lua.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./go.nix
    ./rust.nix
  ];
}
