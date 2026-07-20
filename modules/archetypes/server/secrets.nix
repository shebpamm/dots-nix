{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      server = {
        includes = [
          aspects.sops
          aspects.users
        ];
        nixos =
          { ... }:
          {

            sops.age.sshKeyPaths = [
              "/sops/ssh_sops_server_key"
            ];

            sops.secrets = {
              root-password = {
                neededForUsers = true;
                sopsFile = ../../../secrets/servers/users.yaml;
              };

              main-password = {
                neededForUsers = true;
                sopsFile = ../../../secrets/servers/users.yaml;
              };
            };

            fileSystems."/sops" = {
              device = "/dev/disk/by-label/sops-secrets";
              fsType = "iso9660";
              options = [ "ro" ];
            };
          };
      };
    };
}
