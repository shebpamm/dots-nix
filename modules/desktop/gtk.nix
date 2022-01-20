{ config, pkgs, libs, ... }:
{
  home.packages = [ pkgs.nordic pkgs.paper-icon-theme ];
  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    theme.name = "Nordic";
    iconTheme.name = "Paper";
  };
}
