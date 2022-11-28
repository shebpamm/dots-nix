{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];
}
