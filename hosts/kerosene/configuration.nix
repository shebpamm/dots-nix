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
      ../../os/virtualization/lxd.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  fileSystems."/mnt/storage" = {
    device = "hc4nas.sorsa.cloud:/mnt/tank/storage";
    fsType = "nfs";
    options = [ "nfsvers=3" "soft" "intr" "x-systemd.idle-timeout=600" "x-systemd.automount" "noatime" "noauto" "nolock" "rsize=8192" "wsize=8192" "timeo=14" "retrans=2" ];
  };

  time.timeZone = "Europe/Helsinki";

  hardware.flipperzero.enable = true;

  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.powerManagement.enable = false;
  hardware.graphics.enable32Bit = true;

  systemd.enableUnifiedCgroupHierarchy = false;

  security.sudo.wheelNeedsPassword = false;
  security.pki.certificateFiles = [ ../../home.crt ];

  networking = {
    hostName = "kerosene";
    useDHCP = false;

    interfaces.eno1.useDHCP = true;
    firewall.allowedTCPPorts = [ 80 443 22 6742 8000 24800 4713 3389 ];
    dhcpcd.wait = "if-carrier-up";

  };
  services.ollama.enable = true;
  services.ollama.package = (pkgs.ollama.override { acceleration = "cuda"; });
  services.ollama.acceleration = "cuda";

  services.gnome.gnome-keyring.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.udev = {
    packages = [ pkgs.openrgb ];
    # extraRules = ''
    #   ACTION=="change", SUBSYSTEM=="drm", RUN+="notify-awesome %k"
    # '';
  };

  services.pcscd.enable = true;
  services.sshd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.gnupg.agent.enable = true;

  programs.fish.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
  };



  services.xserver = {
    videoDrivers = [ "nvidia" ];
    dpi = 96;
  };


  services.autorandr.profiles = {
    main = {
      fingerprint = {
        DP-0 = "00ffffffffffff004c2d350f56425430121c0104b54627783aaea5af4f42af260f5054bfef80714f810081c08180a9c0b300950001014dd000a0f0703e8030203500b9882100001a000000fd001e4b1e873c000a202020202020000000fc005533324a3539780a2020202020000000ff004854504b3530303339350a2020017302030ff042105f2309070783010000023a801871382d40582c4500b9882100001e565e00a0a0a0295030203500b9882100001a04740030f2705a80b0588a00b9882100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056";
        DP-2 = "00ffffffffffff004c2d9c0f000000002b1c0104b57722783ba2a1ad4f46a7240e5054bfef80714f810081c08180a9c0b3009500d1c074d600a0f038404030203a00a9504100001a000000fd003078bebe61010a202020202020000000fc00433439524739780a2020202020000000ff004831414b3530303030300a202002ce02032cf046105a405b3f5c2309070783010000e305c0006d1a0000020f307800048b127317e60605018b7312565e00a0a0a0295030203500a9504100001a584d00b8a1381440f82c4500a9504100001e1a6800a0f0381f4030203a00a9504100001af4b000a0f038354030203a00a9504100001a0000000000000000000000af701279000003013c57790188ff139f002f801f009f055400020009006c370108ff139f002f801f009f0545000200090033b70008ff139f002f801f009f0528000200090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f390";
      };
      config = {
        DP-0 = {
          crtc = 1;
          mode = "3840x2160";
          position = "707x0";
          rate = "60";
        };
        DP-2 = {
          crtc = 0;
          mode = "5120x1440";
          position = "0x2160";
          primary = true;
          rate = "119.97";
        };
      };
    };
  };

  environment.binsh = "${pkgs.dash}/bin/dash";
  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1";
  };
  environment.systemPackages = with pkgs; [
    coreutils
    gcc
    gnupg
    pinentry
    usbutils
    vim
    zsh
  ];


  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "23.11";
}
