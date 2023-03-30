{ config, pkgs, libs, ... }:
{
  imports = [
    ./fonts.nix
    ./sound.nix
    ./env.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  time.timeZone = "Europe/Helsinki";
}
