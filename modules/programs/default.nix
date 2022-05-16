{ config, pkgs, libs, ... }:
{
  imports = [ ./irssi.nix ./kitty ./fun.nix ];
  home.packages = with pkgs; [ 
    google-chrome
    rofi
    nyxt
    discord
    kitty
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
