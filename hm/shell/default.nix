{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./fish
    ./lorri.nix
    ./tmux.nix
    ./fortunes.nix
  ];
  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    acpi
    act-latest
    alsa-utils
    astyle
    bat
    bind
    bottom
    brightnessctl
    cloudflared
    comma
    devenv
    eza
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
    kubectx
    k9s
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
    unzip
    vault
    websocat
    wget
    xclip
    yq
    yubikey-agent
    yubikey-manager
    zoxide
    pwgen
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
  home.file.".tmux/plugins/tpm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tpm";
  home.file.".config/bat".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/bat";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
