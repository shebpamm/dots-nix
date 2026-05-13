{ ... }:
{
  flake.aspects =
    { ... }:
    {
      nix = {
        nixos =
          { ... }:
          {
            nix.settings.experimental-features = [ "pipe-operators" ];
          };
        homeManager = { ... }: { };
      };
    };
}
