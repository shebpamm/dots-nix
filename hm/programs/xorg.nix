{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
    eww
  ];
}
