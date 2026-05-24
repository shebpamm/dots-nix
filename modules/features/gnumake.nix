{ ... }:
{
  flake.aspects =
    { ... }:
    {
      gnumake = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              gnumake
            ];
          };
      };
    };
}
