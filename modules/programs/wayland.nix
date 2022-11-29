{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    wofi
    hyprpaper
    nur.repos.c0deaddict.rofi-wayland
  ];
}
