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

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
    };
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-partlabel/luks";
      allowDiscards = true;
    };
  };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-partlabel/ESP";
      fsType = "vfat";
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
}
