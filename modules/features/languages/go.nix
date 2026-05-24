{ ... }:
{
  flake.aspects =
    { ... }:
    {
      go = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = [ pkgs.go ];
          };
      };
    };
}
