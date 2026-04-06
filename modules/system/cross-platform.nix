{ ... }:
{
  flake.aspects = { ... }: {
    cross-platform = {
      nixos = { lib, ... }: rec {
        boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

        nix.settings.extra-platforms = lib.mkDefault boot.binfmt.emulatedSystems;
      };
      homeManager = { ... }: { };
    };
  };
}
