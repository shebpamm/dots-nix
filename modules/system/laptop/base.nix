{ ... }:
{
  flake.aspects = { aspects, ... }: {
    laptop-base = {
      includes = [
        aspects.power-management
        aspects.bluetooth
      ];
    };
  };
}
