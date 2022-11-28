{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    rofi
    xdotool
    xpra
    xprintidle
    xsecurelock
    wmctrl
  ];
}
