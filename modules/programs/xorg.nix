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
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
