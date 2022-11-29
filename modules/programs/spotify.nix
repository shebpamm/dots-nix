{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.spicetify.homeManagerModule ];
  programs.spicetify = {
    enable = true;
    theme = "catppuccin-latte";
    enabledExtensions = [
      "fullAppDisplay.js"
      "shuffle+.js"
      "hidePodcasts.js"
    ];
  };
}
