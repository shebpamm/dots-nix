{ ... }:
{
  flake.aspects = { ... }: {
    flipperzero = {
      nixos = { ... }: {
        hardware.flipperzero.enable = true;
      };
      homeManager = { ... }: { };
    };
  };
}
