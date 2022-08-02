{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    cantarell-fonts
    noto-fonts
    noto-fonts-emoji-blob-bin
    fira-code
    meslo-lg
    (nerdfonts.override { fonts = [ "3270" ]; })
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
