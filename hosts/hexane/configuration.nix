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
      ../../os/system/fingerprint.nix
      ../../os/secrets
    ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  security.polkit.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.videoDrivers = [ "displaylink" ];
  services.gnome.gnome-keyring.enable = true;
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  };
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  virtualisation.docker.enable = true;

  networking = {
    hostName = "hexane";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
    useDHCP = true;
    wireless.iwd.enable = true;
  };

  boot.resumeDevice = "/dev/mapper/crypted";
  boot.kernelParams = [
    "resume_offset=3155204"
    "cgroup_enable=memory"
    "cgroup_enable=cpuset"
    "cgroup_memory=1"
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
      configurationLimit = 3;
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
    }
  ];

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

  services.sshd.enable = true;
  services.touchegg.enable = true;

  system.stateVersion = "21.11";
}
