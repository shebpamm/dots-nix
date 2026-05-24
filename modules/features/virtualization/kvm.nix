{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      kvm = {
        nixos =
          { ... }:
          {
            virtualisation.libvirtd.enable = true;
            users.extraGroups.libvirtd.members = [ inputs.self.context.adminUser ];
          };
        homeManager = { ... }: { };
      };
    };
}
