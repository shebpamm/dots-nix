{ ... }:
{
  flake.aspects =
    { ... }:
    {
      terraform = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              terraform
            ];
          };
      };
    };
}
