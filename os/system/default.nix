{ config, pkgs, libs, inputs, ... }:
{
  imports = [
    inputs.flake-utils-plus.nixosModules.autoGenFromInputs

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

  nix.linkInputs = true;
  nix.generateRegistryFromInputs = true;
  nix.generateNixPathFromInputs = true;

  time.timeZone = "Europe/Helsinki";
}
