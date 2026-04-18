{ pkgs, ... }:
{
  imports = [
    ./env.nix
    ./fonts.nix
    ./shell.nix
    ./sound.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  services.automatic-timezoned.enable = true;
}
