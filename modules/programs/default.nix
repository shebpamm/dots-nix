{ config, pkgs, libs, ... }:
{
  imports = [ ./irssi.nix ./kitty ./spotify.nix ];
  home.packages = with pkgs; [ google-chrome rofi nyxt ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
