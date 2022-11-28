{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];
}
