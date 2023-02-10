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
      spotifyPackage = pkgs.spotifywm;
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
      ];
    };
}
