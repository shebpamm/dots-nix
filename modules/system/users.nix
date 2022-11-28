{ config, pkgs, ... }:
{
  users = {
    mutableUsers = false;
    users = {
      root = {
        shell = pkgs.fish;
        passwordFile = config.sops.secrets.root-password.path;
      };
      shebpamm = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.fish;
        passwordFile = config.sops.secrets.main-password.path;
      };
    };
  };

  users.extraGroups.vboxusers.members = [ "shebpamm" ];
  users.extraGroups.docker.members = [ "shebpamm" ];

  nix.settings.trusted-users = [ "root" "shebpamm" "@wheel" ];

}
