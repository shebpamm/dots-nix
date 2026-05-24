{ ... }:
{
  flake.aspects =
    { ... }:
    {
      nix = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              nil
              nixpkgs-fmt
            ];
          };
      };
    };
}
