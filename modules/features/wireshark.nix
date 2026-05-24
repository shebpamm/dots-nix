{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      wireshark = {
        nixos =
          { pkgs, ... }:
          {
            programs.wireshark.enable = true;
            programs.wireshark.package = pkgs.wireshark;
            users.extraGroups.plugdev.members = [ inputs.self.context.adminUser ];
          };
        homeManager = { ... }: { };
      };
    };
}
