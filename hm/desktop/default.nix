{ config, ... }:
{
  home.file.".config/eww".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/eww";

  home.file.".config/wofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/wofi";
}
