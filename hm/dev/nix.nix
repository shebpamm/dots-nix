{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
}
