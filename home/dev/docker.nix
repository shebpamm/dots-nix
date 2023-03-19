
{ config, pkgs, libs, ... }:
{
  home.packages = [ pkgs.docker-compose ];
}
