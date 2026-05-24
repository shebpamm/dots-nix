{ inputs, ... }:
{
  flake.aspects = {
    legacy =
      let
        miscOverlay =
          self: super:
          let
            system = self.stdenv.hostPlatform.system;
          in
          {
            zen-browser = inputs.zen.packages.${system}.default;
            flox = inputs.flox.packages.${system}.flox;
            compfy = inputs.compfy.packages.${system}.compfy;
            devenv = inputs.devenv.packages.${system}.devenv;
            nur = import inputs.nur {
              nurpkgs = super;
              pkgs = super;
            };
          };

        legacyOverlays = [
          inputs.nixpkgs-sheb.overlay
          inputs.neovim-nightly.overlays.default
          miscOverlay
        ];
      in
      {
        nixos = {
          nixpkgs.overlays = legacyOverlays;
        };
        homeManager = {
          nixpkgs.overlays = legacyOverlays;
        };
      };
  };
}
