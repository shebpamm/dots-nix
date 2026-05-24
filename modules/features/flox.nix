{ inputs, ... }:
{
  flake-file.inputs.flox.url = "github:flox/flox";

  flake.aspects =
    { ... }:
    {
      flox = {
        nixos =
          { ... }:
          {

            nix.settings.substituters = [
              "https://cache.flox.dev"
            ];
            nix.settings.trusted-public-keys = [
              "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
            ];
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = [
              inputs.flox.packages.${pkgs.stdenv.hostPlatform.system}.flox
            ];
          };
      };
    };
}
