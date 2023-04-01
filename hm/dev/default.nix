{ config, pkgs, libs, ... }:
{
  imports = [
    ./docker.nix
    ./lisp.nix
    ./lua.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./go.nix
  ];
}
