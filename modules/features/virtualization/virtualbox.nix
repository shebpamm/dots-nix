{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      virtualbox = {
        nixos =
          { pkgs, ... }:
          {
            virtualisation.virtualbox.host.enable = true;

            users.extraGroups.vboxusers.members = [ inputs.self.context.adminUser ];
            users.extraGroups.libvirtd.members = [ inputs.self.context.adminUser ];
          };
        homeManager = { pkgs, ... }: { };
      };
    };
}
