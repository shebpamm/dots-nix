{ ... }:
{
  flake.aspects =
    { ... }:
    {
      rust = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              cargo
              rust-analyzer
            ];
          };
      };
    };
}
