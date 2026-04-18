{ pkgs, ... }:
{
  imports = [
    ./env.nix
    ./fonts.nix
    ./shell.nix
    ./sound.nix
    ./users.nix
  ];
}
