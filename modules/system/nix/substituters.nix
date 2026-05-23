{ ... }:
{
  flake.aspects =
    { ... }:
    {
      nix = {
        nixos =
          { ... }:
          {
            nix.settings = {
              substituters = [
                "https://cache.nixos.org/"
                "https://nix-community.cachix.org"
                "https://domenkozar.cachix.org"
                "https://sorsalab.cachix.org"
                "https://nixos-raspberrypi.cachix.org"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "domenkozar.cachix.org-1:Qf0xcQX3VUvo5/c6xTvbAET3EEtq1E2Mk1vojgwBprE="
                "sorsalab.cachix.org-1:22M3UMmBtHT2loPkKMNf9wCeO5JFluaOPeDK0Acb8BI="
                "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
              ];
            };
          };
        homeManager = { ... }: { };
      };
    };
}
