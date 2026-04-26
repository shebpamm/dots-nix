{ ... }:

{
  imports = [
    ../../os/system/env.nix
    ../../os/system/shell.nix
    ../../os/system/users.nix
  ];

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
