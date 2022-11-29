{ config, pkgs, libs, inputs, ... }:
let
  configPath = ../../../config/hypr;
  monitors = (builtins.readFile (configPath + /monitors.conf));
  binds = (builtins.readFile (configPath + /binds.conf));
  animations = (builtins.readFile (configPath + /animations.conf));
  execs = (builtins.readFile (configPath + /execs.conf));
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = pkgs.lib.strings.concatStringsSep "\n" [
      monitors
      binds
      animations
      execs
    ];
  };

  home.file.".config/hypr/hyprpaper.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/hyprpaper.conf";

}
