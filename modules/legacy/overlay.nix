{ inputs, ... }:
{
  flake.aspects = {
    legacy =
      let
        miscOverlay = _self: super: {
          nur = import inputs.nur {
            nurpkgs = super;
            pkgs = super;
          };
        };

        legacyOverlays = [
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
