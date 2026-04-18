{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Disk setup
      ./disks.nix

      # Other Modules
      ../../os/system
      ../../os/system/keyboard.nix
      # ../../os/system/graphics/wayland.nix
      ../../os/games/steam.nix
      ../../os/programs
      ../../os/secrets
      ../../os/system/graphics/xorg.nix
      ../../os/virtualization/kvm.nix
    ];

  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "23.11";
}
