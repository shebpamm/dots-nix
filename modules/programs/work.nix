{ config, pkgs, libs, ... }:
{ 
  home.packages = with pkgs; [
    slack
    keepassxc
    openvpn
  ];
}
