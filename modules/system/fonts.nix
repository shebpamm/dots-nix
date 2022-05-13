{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    cantarell-fonts
    (nerdfonts.override { fonts = [ "Meslo" "CascadiaCode" "FiraCode" "Gohu" "IBMPlexMono" "Iosevka" "JetBrainsMono" ]; })
    noto-fonts-emoji-blob-bin
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ];
      serif = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Blobmoji" ];
    };
  };
}
