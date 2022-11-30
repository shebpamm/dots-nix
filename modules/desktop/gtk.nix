{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [ nordic paper-icon-theme papirus-icon-theme catppuccin-gtk ];
  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    theme.name = "Catppuccin-Pink-Light";
    iconTheme.name = "Paper";
  };
}
