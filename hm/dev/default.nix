{ config, pkgs, libs, ... }:
{
  imports = [
    ./docker.nix
    ./lua.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./go.nix
    ./rust.nix
  ];
}
