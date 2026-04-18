{ pkgs, ... }:
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
      # ../../os/system/fingerprint.nix
      ../../os/secrets
      ../../os/system/keyboard.nix

      ../../os/games/steam.nix
    ];

  users.users.ws1user = {
    isSystemUser = true;
    group = "ws1user";
  };

  users.groups.ws1user = {};
}
