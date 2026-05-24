{ inputs, ... }:
{
  flake-file.inputs.anttipkgs.url = "github:anttiharju/nur-packages";

  flake.aspects =
    { ... }:
    {
      relcheck = {
        homeManager =
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ inputs.anttipkgs.overlays.default ];

            home.packages = with pkgs; [
              relcheck
            ];
          };
      };
    };
}
