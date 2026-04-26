{ lib, ... }:
{
  programs.zsh = lib.mkDefault {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
  };

  programs.command-not-found.enable = false;
}
