{ inputs, ... }:
{
  flake.aspects = {
    legacy =
      let
        generateMiscOverlay = system: self: super: {
          zen-browser = inputs.zen.packages.${system}.default;
          flox = inputs.flox.packages.${system}.flox;
          compfy = inputs.compfy.packages.${system}.compfy;
          devenv = inputs.devenv.packages.${system}.devenv;
          kat = inputs.kat.packages.${system}.kat;
          nur = import inputs.nur {
            nurpkgs = super;
            pkgs = super;
          };
          cursor-latest = inputs.cursor.packages.${system}.cursor;
        };

        legacyOverlays = [
          inputs.nixpkgs-f2k.overlays.default
          inputs.nixpkgs-sheb.overlay
          inputs.neovim-nightly.overlays.default
          inputs.hyprpaper.overlays.default
          inputs.anttipkgs.overlays.default
        ];

        overlaysForSystem = system: legacyOverlays ++ [ generateMiscOverlay system ];
      in
      {
        nixos = { system, ... }:
          {
            nixpkgs.overlays = overlaysForSystem system;
          };
        homeManager = { system, ... }:
          {
            nixpkgs.overlays = overlaysForSystem system;
          };
      };
  };
}
