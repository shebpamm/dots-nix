{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    cantarell-fonts
    noto-fonts
    noto-fonts-emoji-blob-bin
    fira-code
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
