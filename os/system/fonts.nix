{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "3270" "JetBrainsMono" ]; })
    nerd-fonts._3270
    nerd-fonts.jetbrains-mono
    font-awesome
    cantarell-fonts
    cascadia-code
    comic-mono
    fira-code
    material-icons
    meslo-lg
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
