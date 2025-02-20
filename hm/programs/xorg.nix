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
    (xsecurelock.overrideAttrs
      (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [ mplayer ];
        configureFlags = oldAttrs.configureFlags ++ [ "--with-mplayer=${mplayer}/bin/mplayer" ];
      }))
    eww
    autorandr
    arandr
  ];
}
