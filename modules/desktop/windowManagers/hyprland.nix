{ config, pkgs, libs, inputs, ... }:
let
  configPath = ../../../config/hypr;

  animations = (builtins.readFile (configPath + /animations.conf));
  binds = (builtins.readFile (configPath + /binds.conf));
  colors = (builtins.readFile (configPath + /colors/latte.conf));
  decoration = (builtins.readFile (configPath + /decoration.conf));
  execs = (builtins.readFile (configPath + /execs.conf));
  general = (builtins.readFile (configPath + /general.conf));
  monitors = (builtins.readFile (configPath + /monitors.conf));
  rules = (builtins.readFile (configPath + /rules.conf));
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = pkgs.lib.strings.concatStringsSep "\n" [
      animations
      binds
      colors
      decoration
      execs
      general
      monitors
      rules
    ];
  };

  home.file.".config/hypr/hyprpaper.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/hyprpaper.conf";

}
