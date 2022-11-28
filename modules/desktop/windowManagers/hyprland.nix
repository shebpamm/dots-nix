{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=DP-1,5120x1440@120,auto,1

      bind=SUPER,return,exec,kitty
      bind=SUPER,d,exec,rofi -show drun
      bind=SUPER,Q,killactive,

      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,0,workspace,10

      bind=SUPER_SHIFT,1,movetoworkspace,1
      bind=SUPER_SHIFT,2,movetoworkspace,2
      bind=SUPER_SHIFT,3,movetoworkspace,3
      bind=SUPER_SHIFT,4,movetoworkspace,4
      bind=SUPER_SHIFT,5,movetoworkspace,5
      bind=SUPER_SHIFT,6,movetoworkspace,6
      bind=SUPER_SHIFT,7,movetoworkspace,7
      bind=SUPER_SHIFT,8,movetoworkspace,8
      bind=SUPER_SHIFT,9,movetoworkspace,9
      bind=SUPER_SHIFT,0,movetoworkspace,10

      bind=SUPER,mouse_down,workspace,e+1
      bind=SUPER,mouse_up,workspace,e-1
    '';
  };

}
