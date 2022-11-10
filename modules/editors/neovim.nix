{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    black
    neovim-nightly-anticonceal
    pylint
    python39Packages.flake8
    python39Packages.isort
    python39Packages.pydocstyle
    shellcheck
    stylua
  ];
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
}
