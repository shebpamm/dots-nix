{ ... }:
{
  flake.aspects =
    { ... }:
    {
      yaml = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              yamlfmt
              yamllint
            ];
          };
      };
    };
}
