{ config, pkgs, lib, ... }:
{
  boot.binfmt.emulatedSystems = lib.mkDefault [ "i686-linux" "aarch64-linux" ];
  nix = {
    settings = {
      trusted-users = [ "root" "shebpamm" "@wheel" ];
      extra-platforms = lib.mkDefault config.boot.binfmt.emulatedSystems;

      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://domenkozar.cachix.org"
        "https://fortuneteller2k.cachix.org"
        "https://hyprland.cachix.org"
        "https://sorsalab.cachix.org"
        "https://cache.flox.dev"
        "https://nixos-raspberrypi.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "domenkozar.cachix.org-1:Qf0xcQX3VUvo5/c6xTvbAET3EEtq1E2Mk1vojgwBprE="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "sorsalab.cachix.org-1:22M3UMmBtHT2loPkKMNf9wCeO5JFluaOPeDK0Acb8BI="
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
