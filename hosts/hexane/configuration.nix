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

  services.btrbk.instances.btrbk.onCalendar = "daily";
  services.btrbk.instances.btrbk.settings = {
    snapshot_preserve = "14d";
    snapshot_preserve_min = "2d";
    volume = {
      "/" = {
        subvolume = {
          home = {
            snapshot_create = "always";
          };
        };
        target = "/snapshots";
      };
    };
  };

  users.users.ws1user = {
    isSystemUser = true;
    group = "ws1user";
  };

  users.groups.ws1user = {};
}
