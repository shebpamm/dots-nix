{ ... }:
{
  flake.aspects.bootloader = {
    nixos = {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
    };
  };
}
