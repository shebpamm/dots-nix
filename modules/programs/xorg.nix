{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    dunst
    rofi
    skippy-xd
    wmctrl
    xdotool
    xpra
    xprintidle
    xsecurelock
  ];
}
