{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    wofi
    nur.repos.c0deaddict.rofi-wayland
  ];
}
