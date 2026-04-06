{ config, pkgs, lib, ... }:
{
  nix = {
    settings = {
      trusted-users = [ "root" "shebpamm" "@wheel" ];
    };
  };
}
