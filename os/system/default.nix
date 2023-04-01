{ config, pkgs, libs, ... }:
{
  imports = [
    ./fonts.nix
    ./sound.nix
    ./env.nix
    ./users.nix
    ./nix.nix
  ];

  
  environment.systemPackages = with pkgs; [
    coreutils
    git
    gcc
    gnupg
    pinentry
    usbutils
    vim
    zsh
  ];

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  time.timeZone = "Europe/Helsinki";
}
