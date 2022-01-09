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
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];

  time.timeZone = "Europe/Helsinki";

  hardware.nvidia.modesetting.enable = true;

  networking = {
    hostName = "kerosene";
    useDHCP = false;

    interfaces.eno1.useDHCP = true;
    firewall.allowedTCPPorts = [ 80 443 22 6742 ];
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

  users.users.shebpamm = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
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

  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ "root" "shebpamm" "@wheel" ];
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://fortuneteller2k.cachix.org"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
    ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "21.11";
}
