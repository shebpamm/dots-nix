{ ... }:
{
  flake.aspects = { aspects, ... }: {
    system-base = {
      includes = [ aspects.bootloader ];

      nixos = { };
    };
  };
}
