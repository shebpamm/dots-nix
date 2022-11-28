{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    package = null;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
