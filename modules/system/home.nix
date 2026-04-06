{ inputs, ... }:
{
  flake.aspects = { ... }: {
    homemanager-base = {
      homeManager = { ... }: {
        home = {
          username = inputs.self.context.adminUser;
          homeDirectory = inputs.self.context.homeDirectory;
          stateVersion = "23.11";
        };

        programs.home-manager.enable = true;
      };
    };
  };
}
