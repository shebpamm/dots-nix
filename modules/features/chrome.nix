{ ... }:
{
  flake.aspects =
    { ... }:
    {
      chrome = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              google-chrome
            ];
          };
      };
    };
}
