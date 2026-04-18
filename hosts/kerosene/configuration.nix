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
    ];

  environment.binsh = "${pkgs.dash}/bin/dash";
  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1";
  };
  environment.systemPackages = with pkgs; [
    coreutils
    gcc
    usbutils
    vim
    zsh
  ];


  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.docker.daemon.settings = {
    default-address-pools = [
      { base = "172.80.0.0/16"; size = 24; }
      { base = "172.90.0.0/16"; size = 24; }
    ];
  };
  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "23.11";
}
