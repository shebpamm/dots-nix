{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      user-secrets = {
        includes = [ aspects.sops ];
        nixos =
          { ... }:
          {
            sops.secrets = {
              root-password = {
                neededForUsers = true;
                sopsFile = ../../secrets/workstation/users.yaml;
              };

              main-password = {
                neededForUsers = true;
                sopsFile = ../../secrets/workstation/users.yaml;
              };
            };
          };
      };
    };
}
