{ config, pkgs, libs, ... }:
{
  imports = [
    ./fun.nix
    ./irssi.nix
    ./kitty
    ./management.nix
    ./spotify.nix
    ./wayland.nix
    ./xorg.nix
  ];
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    discord
    firefox
    google-chrome
    iperf3
    kitty
    libnotify
    mplayer
    nfs-utils
    nomachine
    nyxt
    obsidian
    openssl
    pavucontrol
    pcmanfm
    pulseaudio
    sops
    yubikey-manager-qt
    yubioath-desktop
  ];
}
