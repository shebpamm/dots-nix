{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    # displayManager.lightdm = {
    #   enable = true;
    #   greeters.gtk.enable = true;
    # };
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };

    displayManager.sessionCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --mode 3840x2160'';

    xrandrHeads = [
      { output = "DP-1"; monitorConfig = ''
        Option "Position" "2160 1213"
      ''; }
      { output = "DP-2"; monitorConfig = ''
        Option "Rotate" "left"
        Option "Position" "0 0"
      ''; }
    ];

    libinput.enable = true;
    layout = "eu";
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      berry.enable = true;
      herbstluftwm.enable = true;
    };
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
