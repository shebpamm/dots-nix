{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./fish
    ./lorri.nix
    ./tmux.nix
    ./fortunes.nix
    ./starship.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    acpi
    act-latest
    alsa-utils
    astyle
    bind
    bottom
    brightnessctl
    cloudflared
    comma
    devenv
    dyff
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
    k9s
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    lazygit
    maim
    ncdu
    pamixer
    pass
    playerctl
    pwgen
    qrencode
    rabtap
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
    yq-go
    yubikey-agent
    yubikey-manager
    zoxide
    lefthook
    actionlint
    action-validator
    shellcheck
    erdtree
    granted
    relcheck
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
  home.file.".tmux/plugins/tpm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tpm";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
