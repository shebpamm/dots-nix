{ config, ... }:
{
  home.file.".config/clipcat".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/clipcat";
}
