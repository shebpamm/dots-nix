{ config, pkgs, lib, ... }:
{
  programs.zsh = lib.mkDefault {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
  };

  programs.fish.enable = lib.mkDefault true;
}
