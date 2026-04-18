{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      rtl-sdr = {
        nixos =
          { pkgs, ... }:
          {
            hardware.rtl-sdr.enable = true;
            users.extraGroups.plugdev.members = [ inputs.self.context.adminUser ];
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
