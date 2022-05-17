{ config, pkgs, libs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./fish
  ];
  home.packages = with pkgs; [
    acpi
    alsa-utils
    bat
    bottom
    brightnessctl
    exa
    fd
    feh
    ffmpeg
    fortune
    fish
    fzf
    github-cli
    gnumake
    lazygit
    maim
    ncdu
    pamixer
    pass
    ranger
    (ripgrep.override { withPCRE2 = true; })
    tmux
    unzip
    wget
    xclip
    zoxide
    github-cli
    playerctl
    htop
    home-assistant-cli
    bind
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
