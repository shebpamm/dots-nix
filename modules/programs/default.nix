{ config, pkgs, libs, ... }:
{
  imports = [ ./irssi.nix ./kitty ./fun.nix ./spotify.nix ./management.nix ];
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
    pavucontrol
    pcmanfm
    pulseaudio
    rofi
    sops
    wmctrl
    xdotool
    xpra
    xprintidle
    xsecurelock
    yubikey-manager-qt
    yubioath-desktop
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
