{ ... }:
{
  flake.aspects =
    { ... }:
    {
      pcmanfm = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              pcmanfm
            ];
          };
      };
    };
}
