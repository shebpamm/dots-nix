{ ... }:
{
  flake.aspects =
    { ... }:
    {
      wsone = {
        nixos =
          { pkgs, ... }:
          {
            users.users.ws1user = {
              isSystemUser = true;
              group = "ws1user";
            };

            users.groups.ws1user = { };
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
