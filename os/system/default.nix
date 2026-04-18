{ pkgs, ... }:
{
  imports = [
    ./env.nix
    ./fonts.nix
    ./shell.nix
    ./sound.nix
    ./users.nix
  ];

  environment.systemPackages = with pkgs; [
    jmtpfs
  ];

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  services.automatic-timezoned.enable = true;
}
