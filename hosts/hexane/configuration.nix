{ pkgs, context, ... }:
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

  services.upower.enable = true;
  hardware.bluetooth.enable = true;
  hardware.rtl-sdr.enable = true;
  services.blueman.enable = true;
  security.polkit.enable = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.x2goserver.enable = false;
  services.gnome.gnome-keyring.enable = true;
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  };

  environment.systemPackages = [
    pkgs.clamav
  ];
  services.clamav.daemon.enable = true;

  services.clamav.updater.enable = true;

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

  services.xserver.videoDrivers = [ "nvidia" ];


  networking = {
    hostName = "hexane";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    enableIPv6 = false;
    useDHCP = true;
    wireless.iwd.enable = true;
    search = [
      "smartly.io"
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_6_1;
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

  # programs.immersed.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ context.mainUser ];

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
  hardware.opengl = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    prime = {
      sync.enable = true;
      offload.enable = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libva libva-vdpau-driver intel-media-driver ];
  };

  users.users.ws1user = {
    isSystemUser = true;
    group = "ws1user";
  };

  users.groups.ws1user = {};

  system.stateVersion = "23.11";
}
