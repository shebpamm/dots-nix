{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
