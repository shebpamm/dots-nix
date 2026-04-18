{ pkgs, ... }:
{
  imports = [
    ./env.nix
    ./fonts.nix
    ./shell.nix
    ./sound.nix
    ./users.nix
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  services.automatic-timezoned.enable = true;
}
