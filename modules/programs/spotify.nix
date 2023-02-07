{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.spicetify.homeManagerModule ];
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
    in
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin-latte;
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
      ];
    };
}
