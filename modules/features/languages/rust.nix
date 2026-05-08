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
              cargo-generate
              rust-analyzer
            ];
          };
      };
    };
}
