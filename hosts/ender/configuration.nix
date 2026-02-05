{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../../os/secrets
    ../../os/system/env.nix
    ../../os/system/nix.nix
    ../../os/system/shell.nix
    ../../os/system/users.nix
  ];


  boot.binfmt.emulatedSystems = [ ];
  nix.settings.extra-platforms = [ ];

  boot.loader.raspberryPi.bootloader = "kernel";
  boot.loader.generic-extlinux-compatible.enable = false;

  networking = {
    hostName = "enderpi";
    wireless = {
      enable = true;
      networks."SorsaNet2400" = {
        pskRaw = "ext:WIFI_PSK";
      };
      secretsFile = config.sops.templates.home_wifi_psk_wpa.path;
    };
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  nix.settings.trusted-users = [ "shebpamm" ];

  programs.zsh.enable = true;

  services.klipper = {
    enable = true;
    configFile = ./printer.cfg;

    firmwares = {
      mcu = {
        enable = true;
        enableKlipperFlash = true;
        configFile = ./firmware.cfg;
        serial = "/dev/serial/by-id/usb-Klipper_stm32g0b1xx_1C0047000C504B5735313920-if00";
      };
    };
  };

  services.moonraker = {
    user = "root";
    enable = true;
    address = "0.0.0.0";
    settings = {
      octoprint_compat = { };
      history = { };
      authorization = {
        force_logins = true;
        cors_domains = [
          "*.local"
          "*.lan"
          "*://enderpi.sorsa.cloud"
        ];
        trusted_clients = [
          "127.0.0.0/8"
          "169.254.0.0/16"
          "172.16.0.0/12"
          "192.168.1.0/24"
          "FE80::/10"
          "::1/128"
        ];
      };
    };
  };

  services.fluidd = {
    enable = true;
  };

  services.nginx.clientMaxBodySize = "1000m";
  networking.firewall.allowedTCPPorts = [ 80 ];
}
