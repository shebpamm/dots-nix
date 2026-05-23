{ ... }:
{
  flake.aspects =
    { ... }:
    {
      sops = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              sops
            ];
          };
      };
    };
}
