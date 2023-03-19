{ config, pkgs, ... }:
{
  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true;
  };
}
