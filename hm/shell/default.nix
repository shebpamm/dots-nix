{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./tmux.nix
    ./fortunes.nix
    ./starship.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    gnumake
    home-assistant-cli
    k9s
    pamixer
    pass
    playerctl
    pwgen
    qrencode
    rabtap
    ranger
    silicon
    teleport
    vault
    lefthook
    actionlint
    action-validator
    shellcheck
    granted
    relcheck
  ];

  # not big enough for their own modules
  home.file.".bin".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf.d".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
  home.file.".tmux/plugins/tpm".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tpm";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
}
