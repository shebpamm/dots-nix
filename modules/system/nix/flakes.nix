{ ... }:
{
  flake.aspects =
    { ... }:
    {
      nix = {
        nixos =
          { ... }:
          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
        homeManager = { ... }: { };
      };
    };
}
