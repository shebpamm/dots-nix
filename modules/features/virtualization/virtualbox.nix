{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      virtualbox = {
        nixos =
          { ... }:
          {
            virtualisation.virtualbox.host.enable = true;

            users.extraGroups.vboxusers.members = [ inputs.self.context.adminUser ];
          };
        homeManager = { ... }: { };
      };
    };
}
