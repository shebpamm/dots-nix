{ ... }:
{
  flake.aspects =
    { ... }:
    {
      python = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              python311
              ansible-lint
              ty
              ruff
            ];
          };
      };
    };
}
