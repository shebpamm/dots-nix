{ config, pkgs, libs, ... }:
{ imports = [ ./git.nix
    ./zsh.nix
    ./fish
    ./lorri.nix
  ];
  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    acpi
    astyle
    alsa-utils
    bat
    bind
    bottom
    brightnessctl
    cloudflared
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
    jq
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
    thefuck
    tmux
    unzip
    websocat
    wget
    xclip
    yq
    yubikey-agent
    yubikey-manager
    zoxide
    kubectl
    kubernetes-helm
    kustomize
    teleport
    vault
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
