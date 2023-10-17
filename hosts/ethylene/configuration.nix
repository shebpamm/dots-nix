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
      ../../os/system/graphics/xorg.nix
      ../../os/secrets
    ];

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.mesa.drivers ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i2c-dev" "i2c-i801" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.loader.grub = {
    enable = true;
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

  services.resolved.enable = true;

  networking = {
    dhcpcd.extraConfig = "nohook resolv.conf";
    hostName = "ethylene";
    useDHCP = true;
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
    interfaces.wlan0.useDHCP = true;

    wireless.iwd.enable = true;
    firewall.allowedTCPPorts = [ 80 443 22 4713 6742 5201 ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.pcscd.enable = true;

  services.sshd.enable = true;
  services.x2goserver.enable = true;

  services.fwupd.enable = true;

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

  services.logiops = {
    enable = true;
    settings = {
      devices = [{
        name = "MX Master 3S";
        smartshift = {
          on = true;
          threshold = 20;
        };

        hiresscroll = {
          hires = true;
          invert = false;
          target = true;
          up = {
            mode = "Axis";
            axis = "REL_WHEEL_HI_RES";
            axis_multiplier = 1.2;
          };
          down = {
            mode = "Axis";
            axis = "REL_WHEEL_HI_RES";
            axis_multiplier = -1.2;
          };
        };
      }];
    };

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
    settings = {
      trusted-users = [ "root" "shebpamm" "@wheel" ];

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


  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "shebpamm" ];

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "shebpamm" ];

  system.stateVersion = "23.05";
}
