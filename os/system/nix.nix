{ config, pkgs, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      trusted-users = [ "root" "shebpamm" "@wheel" ];

      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://domenkozar.cachix.org"
        "https://fortuneteller2k.cachix.org"
        "https://hyprland.cachix.org"
        "https://sorsalab.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "domenkozar.cachix.org-1:Qf0xcQX3VUvo5/c6xTvbAET3EEtq1E2Mk1vojgwBprE="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "sorsalab.cachix.org-1:22M3UMmBtHT2loPkKMNf9wCeO5JFluaOPeDK0Acb8BI="
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
