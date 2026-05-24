{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      homemanager-base = {
        homeManager =
          { ... }:
          {
            home = {
              username = inputs.self.context.adminUser;
              homeDirectory = inputs.self.context.homeDirectory;
            };

            programs.home-manager.enable = true;
          };
      };
    };
}
