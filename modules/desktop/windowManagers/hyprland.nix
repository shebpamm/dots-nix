{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      bind=SUPER,return,exec,kitty
    '';
  };
  
}
