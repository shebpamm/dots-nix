{ ... }:
{
  flake.aspects =
    { ... }:
    {
      wireshark = {
        nixos =
          { ... }:
          {
            programs.wireshark.enable = true;
          };
        homeManager = { ... }: { };
      };
    };
}
