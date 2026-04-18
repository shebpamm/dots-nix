{ ... }:
{
  flake.aspects = { ... }: {
    kerosene = {
      nixos = { pkgs, ... }: {
        services.xserver.dpi = 96;
      };
      homeManager = { pkgs, ... }: {

      };
    };
  };
}
