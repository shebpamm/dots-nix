{ ... }:
{
  flake.aspects =
    { ... }:
    {
      bitwarden = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              bitwarden-desktop
              bitwarden-cli
            ];
          };
      };
    };
}
