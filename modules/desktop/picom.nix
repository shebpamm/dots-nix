{ config, pkgs, libs, ... }:
{
  services.picom = {
      enable = true;
      package = pkgs.picom-pijulius;
      
      shadow = true;
      shadowOpacity = "0.4";
      shadowOffsets = [ (-5) (0) ];
      shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "class_g = 'awesome'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      fade = true;
      fadeDelta = 3;
      fadeSteps = [ "0.03" "0.03" ];
      
      backend = "glx";

      vSync = true;

      extraOptions = ''
        shadow-radius = 16;
        corner-radius = 20;
        rounded-corners-exclude = [
          "window_type = 'dock'",
          "window_type = 'desktop'",
          "class_g = 'awesome'"
        ];
      '';
    };
  # home.packages = [ pkgs.picom-pijulius ];
  home.file.".config/picom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/picom";
}
