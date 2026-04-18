{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      kvm = {
        nixos =
          { pkgs, ... }:
          {
            virtualisation.libvirtd.enable = true;
            users.extraGroups.libvirtd.members = [ inputs.self.context.adminUser ];
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
