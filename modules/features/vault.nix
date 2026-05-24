{ ... }:
{
  flake.aspects =
    { ... }:
    {
      vault = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              vault
            ];
          };
      };
    };
}
