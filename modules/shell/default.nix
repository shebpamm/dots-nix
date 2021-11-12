{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    acpi
    alsa-utils
    bottom
    brightnessctl
    exa
    fd
    feh
    ffmpeg
    fortune
    fzf
    gnumake
    lazygit
    maim
    ncdu
    nnn
    pamixer
    playerctl
    ranger
    ripgrep
    tealdeer
    tmux
    tree
    unzip
    wget
    zoxide
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf".source = 
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";

  home.file.".vimrc".source = 
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/vim/.vimrc";
}
