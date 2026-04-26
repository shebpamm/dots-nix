{ pkgs, ... }:
{
  imports = [ ../../programs/foot.nix ];
  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    mako
  ];
}
