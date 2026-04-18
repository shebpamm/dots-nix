{ config, pkgs, ... }:
let
  user = "shebpamm";
in
{
  users = {
    mutableUsers = false;
    users = {
      root = {
        shell = pkgs.fish;
        hashedPasswordFile = config.sops.secrets.root-password.path;
      };
      ${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.fish;
        hashedPasswordFile = config.sops.secrets.main-password.path;
      };
    };
  };

  users.extraGroups.audio.members = [ user ];
}
