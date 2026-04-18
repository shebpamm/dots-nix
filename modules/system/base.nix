{ ... }:
{
  flake.aspects = { aspects, ... }: {
    system-base = {
      includes = [ 
        aspects.nix
        aspects.homemanager-base
        aspects.homelab-cert
        aspects.network
        aspects.ssh
      ];

      nixos = { };
    };
  };
}
