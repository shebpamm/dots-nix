{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.compfy
  ];

  systemd.user.services.compfy = {
    Service = {
      ExecStart = "${pkgs.compfy}/bin/compfy";
      Restart = "always";
      RestartSec = "10";
    };
    Unit = {
      Description = "Compfy";
      Wants = "graphical-session.target";
    };
  };

  home.file.".config/compfy".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/compfy";
}
