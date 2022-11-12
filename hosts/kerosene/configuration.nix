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
      ../../modules/system/xorg.nix
      ../../modules/games/steam.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];

  time.timeZone = "Europe/Helsinki";

  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.driSupport32Bit = true;

  systemd.enableUnifiedCgroupHierarchy = false;

  networking = {
    hostName = "kerosene";
    useDHCP = false;

    interfaces.eno1.useDHCP = true;
    firewall.allowedTCPPorts = [ 80 443 22 6742 8000 24800 4713 3389 ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "awesome";
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

  users.users.shebpamm = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
  };


  services.xserver = {
    videoDrivers = [ "nvidia" ];

    # displayManager.sessionCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off --output DP-0 --mode 3840x2160 --pos 0x0 --rotate left --output DP-1 --off --output DP-2 --primary --mode 1920x1080 --rate 240 --pos 2160x1236 --rotate normal --output DP-3 --off --output HDMI-1 --off --output USB-C-0 --off'';

    # xrandrHeads = [
    #   {
    #     output = "DP-2";
    #     monitorConfig = ''
    #       Option "Position" "2160 1236"
    #     '';
    #   }
    #   {
    #     output = "DP-0";
    #     monitorConfig = ''
    #       Option "Rotate" "left"
    #       Option "Position" "0 0"
    #     '';
    #   }
    # ];
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

  # Expose secrets
  sops.defaultSopsFile = ../../secrets/kerosene.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets.hass-server = {
    mode = "0400";
    owner = "shebpamm";
  };

  sops.secrets.hass-token = {
    mode = "0400";
    owner = "shebpamm";
  };

  sops.secrets.hass-phone = {
    mode = "0400";
    owner = "shebpamm";
  };

  sops.secrets."shebpamm-libera.crt" = {
    mode = "0400";
    owner = "shebpamm";
  };

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      trusted-users = [ "root" "shebpamm" "@wheel" ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://fortuneteller2k.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "shebpamm" ];
  users.extraGroups.docker.members = [ "shebpamm" ];

  system.stateVersion = "21.11";
}
