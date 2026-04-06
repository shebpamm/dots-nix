{ ... }:
{
  flake.aspects = { aspects, ... }: {
    system-base = {
      includes = [ 
        aspects.bootloader
        aspects.nix
        aspects.homemanager-base
        aspects.homelab-cert
      ];

      nixos = { };
    };
  };
}
