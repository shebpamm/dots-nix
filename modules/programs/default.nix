{ config, pkgs, libs, ... }:
{
  imports = [ ./irssi.nix ./kitty ./fun.nix ./spotify.nix ];
  home.packages = with pkgs; [ 
    google-chrome
    firefox
    rofi
    nyxt
    discord
    nfs-utils
    iperf3
    kitty
    bitwarden
    bitwarden-cli
    nomachine
    xprintidle
    sops
    libnotify
    pcmanfm
    obsidian
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
