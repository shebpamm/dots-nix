{ config, pkgs, ... }:
{
  services.libinput.enable = true;
  services.displayManager.defaultSession = "none+awesome";
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      #       greeters.gtk.enable = true;
    };
    #displayManager.gdm = {
    #  enable = true;
    #  wayland = false;
    #};

    #    displayManager.sessionCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off --output DP-0 --mode 3840x2160 --pos 0x0 --rotate left --output DP-1 --off --output DP-2 --primary --mode 1920x1080 --rate 240 --pos 2160x1236 --rotate normal --output DP-3 --off --output HDMI-1 --off --output USB-C-0 --off'';

    deviceSection = ''
      Option "ModeValidation" "AllowNonEdidModes"
    '';

    
    

    xkb.layout = "eu";
    xkb.options = "caps:escape";
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
      # i3 = {
      #   enable = true;
      #   package = pkgs.i3-gaps;
      # };
      # berry.enable = true;
      # herbstluftwm.enable = true;
    };
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "awesome";
  };

  services.autorandr.enable = true;
  systemd.services.autorandr.after = [ "graphical-session-pre.target" ];
  systemd.services.autorandr.partOf = [ "graphical-session.target" ];

  programs.dconf.enable = true;
}
