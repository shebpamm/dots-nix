{ ... }:
{
  flake.aspects =
    { ... }:
    {
      mplayer = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              mplayer
            ];
          };
      };
    };
}
