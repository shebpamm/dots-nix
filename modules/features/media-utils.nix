{ ... }:
{
  flake.aspects =
    { ... }:
    {
      media-utils = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              feh
              ffmpeg
              maim
            ];
          };
      };
    };
}
