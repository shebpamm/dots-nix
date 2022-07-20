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

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.mesa.drivers ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/302b1f5f-dd74-452c-9257-cc4a90561a32";
      preLVM = true;
    };
  };

  fileSystems."/" = { 
    device = "/dev/void/root";
    fsType = "btrfs";
    options = [ "subvol=@nix-root" "compress=zstd" "noatime" ];
  };

  fileSystems."/home" = { 
    device = "/dev/void/root";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" "noatime" ];
  };

  fileSystems."/home/shebpamm/dots" = { 
    device = "/dev/void/root";
    fsType = "btrfs";
    options = [ "subvol=dots/@nix-dots" "compress=zstd" "noatime" ];
  };


  time.timeZone = "Europe/Helsinki";

  networking = {
    hostName = "ethylene";
    useDHCP = true;
    nameservers = ["8.8.8.8" "1.1.1.1"];
    extraHosts = ''
      127.0.0.1 jira.horsch.com 
    '';

    wireless.iwd.enable = true;
    firewall.allowedTCPPorts = [ 80 443 22 6742 5201 ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.pcscd.enable = true;

  services.sshd.enable = true;
  services.x2goserver.enable = true;

  services.nxserver = {
    enable = true;
    openFirewall = true;

  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cnijfilter2
      gutenprintBin
      canon-cups-ufr2
    ];
  };

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

  programs.fish.enable = true;

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

  security.sudo.wheelNeedsPassword = false;

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


  virtualisation.libvirtd.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "shebpamm" ];

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "shebpamm" ];

  system.stateVersion = "21.11";
}
