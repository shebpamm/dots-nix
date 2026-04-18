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

  services.libinput.touchpad.naturalScrolling = true;
  services.x2goserver.enable = false;
  environment.systemPackages = [
    pkgs.clamav
  ];
  services.clamav.daemon.enable = true;

  services.clamav.updater.enable = true;

  virtualisation.docker.enable = true;

  # services.xserver.dpi = 96 + 16;
  # services.xserver =
  #   {
  #     dpi = 96 + 16;
  #     deviceSection = ''
  #       Section "Device"
  #           Identifier "intelGpu"
  #           Driver "intel"
  #           Option "VirtualHeads" "1"
  #       EndSection
  #     '';
  #   };

  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.resumeDevice = "/dev/mapper/crypted";
  boot.kernelParams = [
    "resume_offset=3155204"
    "cgroup_enable=memory"
    "cgroup_enable=cpuset"
    "cgroup_memory=1"
  ];

  # programs.immersed.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "shebpamm" ];

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

  services.touchegg.enable = true;

  users.users.ws1user = {
    isSystemUser = true;
    group = "ws1user";
  };

  users.groups.ws1user = {};
}
