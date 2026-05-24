{ ... }:
{
  flake.aspects =
    { ... }:
    {
      homeassistant = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              home-assistant-cli
            ];
          };
      };
    };
}
