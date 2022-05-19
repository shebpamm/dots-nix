{ config, pkgs, libs, ... }:
{
  services.lorri.enable = true;
  home.packages = [ pkgs.direnv ];

  programs.fish.shellInit = ''
    set -x DIRENV_LOG_FORMAT ""
    direnv hook fish | source
  '';
}
