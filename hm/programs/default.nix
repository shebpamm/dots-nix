{ pkgs, ... }:
{
  imports = [
    ./fun.nix
    ./weechat.nix
    ./kitty
    ./wezterm.nix
    ./management.nix
    ./spotify.nix
  ];
  home.packages = with pkgs; [
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
    cfssl
    file
    talosctl
    flox
  ];
}
