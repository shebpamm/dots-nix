{ ... }:
{
  flake.aspects =
    { ... }:
    {
      bash = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              bashInteractive
              shellcheck
            ];
          };
      };
    };
}
