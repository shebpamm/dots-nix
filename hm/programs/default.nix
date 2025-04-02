{ config, pkgs, libs, ... }:
{
  imports = [
    ./fun.nix
    ./irssi.nix
    ./weechat.nix
    ./kitty
    ./wezterm.nix
    ./management.nix
    ./spotify.nix
  ];
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    (discord.override {
      withVencord = true;
    })
    firefox
    google-chrome
    zen-browser
    iperf3
    kitty
    libnotify
    mplayer
    nfs-utils
    nyxt
    openssl
    pavucontrol
    pcmanfm
    pulseaudio
    sops
    yubioath-flutter
    wireshark
    ollama
    cfssl
    file
    talosctl
    flox
    code-cursor
  ];
}
