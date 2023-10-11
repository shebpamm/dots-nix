{ config, pkgs, libs, inputs, ... }:
{
  imports = [
    inputs.flake-utils-plus.nixosModules.autoGenFromInputs

    ./env.nix
    ./fonts.nix
    ./nix.nix
    ./shell.nix
    ./sound.nix
    ./users.nix
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

  services.automatic-timezoned.enable = true;
}
