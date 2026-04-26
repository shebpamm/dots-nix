{ ... }:
{
  flake.aspects =
    { ... }:
    {
      wsone = {
        nixos =
          { ... }:
          {
            users.users.ws1user = {
              isSystemUser = true;
              group = "ws1user";
            };

            users.groups.ws1user = { };
          };
        homeManager = { ... }: { };
      };
    };
}
