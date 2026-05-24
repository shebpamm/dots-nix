{ ... }:
{
  flake.aspects =
    { ... }:
    {
      passwords = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              pass
              pwgen
            ];
          };
      };
    };
}
