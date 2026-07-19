{ ... }:
{
  flake.aspects = { ... }: {
    ratty = {
      homeManager =
        { pkgs, ... }:
        {
          home.packages = [ pkgs.ratty ];
        };
    };
  };
}
