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
    ansible-lint
    bat
    bind
    bottom
    brightnessctl
    cloudflared
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
    nodePackages.prettier_d_slim
    pamixer
    pass
    playerctl
    ranger
    thefuck
    tmux
    unzip
    wget
    xclip
    yamllint
    yq
    yubikey-agent
    yubikey-manager
    zoxide
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
