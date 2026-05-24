{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      docker = {
        nixos =
          { ... }:
          {
            virtualisation.docker.enable = true;

            users.extraGroups.docker.members = [ inputs.self.context.adminUser ];
          };
        homeManager = { ... }: { };
      };
    };
}
