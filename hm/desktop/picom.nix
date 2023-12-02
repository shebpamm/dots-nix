{ config, pkgs, libs, ... }:
{
  services.picom = {
    enable = false;
    package = pkgs.picom-pijulius;

    shadow = true;
    shadowOpacity = 0.4;
    shadowOffsets = [ (-5) (0) ];
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Rofi'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "class_g = 'awesome'"
      "class_g = 'Vncviewer'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    fade = true;
    fadeDelta = 3;
    fadeSteps = [ 0.03 0.03 ];
    fadeExclude = [ "class_g = 'xsecurelock'" ];

    backend = "glx";

    vSync = true;

    settings = {
      animations = false;
      animation-window-mass = 1;
      animation-stiffness = 300;
      animation-dampening = 26;
      animation-clamping = true;

      animation-for-open-window = "zoom";
      animation-force-steps = false;

      shadow-radius = 16;
      corner-radius = 20;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'awesome'"
        "class_g = 'Vncviewer'"
      ];
    };
  };
  # home.packages = [ pkgs.picom-pijulius ];
  # home.file."~/.config/picom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/picom";
}
