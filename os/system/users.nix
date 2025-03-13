{ config, pkgs, context, ... }:
let
  user = context.mainUser;
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

  users.extraGroups.vboxusers.members = [ user ];
  users.extraGroups.docker.members = [ user ];
  users.extraGroups.libvirtd.members = [ user ];
  users.extraGroups.audio.members = [ user ];
  users.extraGroups.plugdev.members = [ user ];

  nix.settings.trusted-users = [ "root" user "@wheel" ];

}
