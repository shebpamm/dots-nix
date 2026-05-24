{ ... }:
{
  flake.aspects =
    { ... }:
    {
      ripgrep = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              (ripgrep.override { withPCRE2 = true; })
            ];
          };
      };
    };
}
