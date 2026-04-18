{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      docker = {
        nixos =
          { pkgs, ... }:
          {
            virtualisation.docker.enable = true;

            users.extraGroups.docker.members = [ inputs.self.context.adminUser ];
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
