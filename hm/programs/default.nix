{ pkgs, ... }:
{
  imports = [
    ./fun.nix
    ./irssi.nix
    ./weechat.nix
    ./kitty
    ./wezterm.nix
    ./management.nix
    ./spotify.nix
    ./discord.nix
  ];
  home.packages = with pkgs; [
    bitwarden-desktop
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
    wireshark
    cfssl
    file
    talosctl
    flox
    cursor-latest
  ];
}
