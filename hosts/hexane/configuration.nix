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
      ../../os/system/graphics/xorg.nix
      ../../os/secrets
    ];

  hardware.bluetooth.enable = true;

  networking = {
    hostName = "hexane";
    useDHCP = true;
    wireless.iwd.enable = true;
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
    };
  };

  fileSystems."/" =
    {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  services.sshd.enable = true;

  system.stateVersion = "21.11";
}
