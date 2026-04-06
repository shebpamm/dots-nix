{ ... }:
{
  flake.aspects = { aspects, ... }: {
    system-base = {
      includes = [ 
        aspects.bootloader
        aspects.nix
      ];

      nixos = { };
    };
  };
}
