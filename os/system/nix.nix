{ config, pkgs, lib, ... }:
{
  nix = {
    settings = {
      trusted-users = [ "root" "shebpamm" "@wheel" ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
