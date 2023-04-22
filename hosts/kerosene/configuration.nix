{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Other Modules
      ../../os/system/env.nix
      ../../os/system/fonts.nix
      ../../os/system/sound.nix
      ../../os/system/users.nix
      # ../../os/system/graphics/wayland.nix
      ../../os/system/graphics/xorg.nix
      ../../os/games/steam.nix
      ../../os/secrets
      ../../os/virtualization/lxd.nix
      ../../os/virtualization/kvm.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/storage" = {
    device = "hc4nas.sorsa.cloud:/mnt/tank/storage";
    fsType = "nfs";
    options = [ "nfsvers=3" "soft" "intr" "x-systemd.idle-timeout=600" "x-systemd.automount" "noatime" "noauto" "nolock" "rsize=8192" "wsize=8192" "timeo=14" "retrans=2" ];
  };

  time.timeZone = "Europe/Helsinki";

  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.powerManagement.enable = false;
  hardware.opengl.driSupport32Bit = true;

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

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.udev = {
    packages = [ pkgs.openrgb ];
  };

  services.pcscd.enable = true;
  services.sshd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.gnupg.agent.enable = true;


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
  };



  hardware.video.hidpi.enable = true;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager.sessionCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 5120x1440'';
    dpi = 96;
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


  nix = {
    package = pkgs.nixUnstable;
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://domenkozar.cachix.org"
        "https://fortuneteller2k.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "domenkozar.cachix.org-1:Qf0xcQX3VUvo5/c6xTvbAET3EEtq1E2Mk1vojgwBprE="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "21.11";
}
