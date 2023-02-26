{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Other Modules
      ../../modules/system/env.nix
      ../../modules/system/fonts.nix
      ../../modules/system/sound.nix
      ../../modules/system/users.nix
      # ../../modules/system/graphics/wayland.nix
      ../../modules/system/graphics/xorg.nix
      ../../modules/games/steam.nix
      ../../modules/secrets
      ../../modules/virtualization/lxd.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];

  time.timeZone = "Europe/Helsinki";

  hardware.nvidia.modesetting.enable = true;
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


  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager.sessionCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 5120x1440'';
  };

  environment.binsh = "${pkgs.dash}/bin/dash";

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
