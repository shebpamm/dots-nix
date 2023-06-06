{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    neovim-nightly
  ];
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
}
