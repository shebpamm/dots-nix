{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=DP-1,5120x1440@120,auto,1

      bind=SUPER,return,exec,kitty
      bind=SUPER,d,exec,rofi -show drun
    '';
  };
  
}
