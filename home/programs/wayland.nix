{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    wofi
    hyprpaper
    rofi-wayland
    eww-wayland
    wl-clipboard
  ];
}
