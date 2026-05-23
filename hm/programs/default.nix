{ pkgs, ... }:
{
  imports = [
    ./fun.nix
    ./weechat.nix
    ./wezterm.nix
    ./management.nix
    ./spotify.nix
  ];
  home.packages = with pkgs; [
    libnotify
    mplayer
    nfs-utils
    nyxt
    openssl
    pavucontrol
    pcmanfm
    pulseaudio
    sops
    cfssl
    file
    talosctl
    flox
  ];
}
