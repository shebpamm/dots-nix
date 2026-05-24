{ ... }:
{
  flake.aspects =
    { ... }:
    {
      laptop-base = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              brightnessctl
            ];
          };
      };
    };
}
