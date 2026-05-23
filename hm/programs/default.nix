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
    sops
    file
    talosctl
    flox
  ];
}
