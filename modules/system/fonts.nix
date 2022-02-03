{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    cantarell-fonts
    (nerdfonts.override { fonts = [ "CascadiaCode" "FiraCode" "Gohu" "IBMPlexMono" "Iosevka" "FiraCode" ]; })
    noto-fonts
    noto-fonts-emoji-blob-bin
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Cousine" ];
      sansSerif = [ "Arimo" ];
      serif = [ "Tinos" ];
      emoji = [ "Blobmoji" ];
    };
  };
}
