{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      rtl-sdr = {
        nixos =
          { ... }:
          {
            hardware.rtl-sdr.enable = true;
            users.extraGroups.plugdev.members = [ inputs.self.context.adminUser ];
          };
        homeManager = { ... }: { };
      };
    };
}
