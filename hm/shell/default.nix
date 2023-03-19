{ config, pkgs, libs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./fish
    ./lorri.nix
  ];
  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    acpi
    alsa-utils
    astyle
    bat
    bind
    bottom
    brightnessctl
    cloudflared
    comma
    devenv
    exa
    exa
    fd
    feh
    ffmpeg
    fish
    fortune
    fzf
    github-cli
    github-cli
    gnumake
    home-assistant-cli
    htop
    hyperfine
    jq
    kubectl
    kubernetes-helm
    kustomize
    lazygit
    maim
    ncdu
    pamixer
    pass
    playerctl
    qrencode
    ranger
    silicon
    socat
    teleport
    thefuck
    tmux
    unzip
    vault
    websocat
    wget
    xclip
    yq
    yubikey-agent
    yubikey-manager
    zoxide
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
  home.file.".config/bat".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/bat";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
