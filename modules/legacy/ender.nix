{ ... }:
{
  flake.aspects = { aspects, ... }: {
    ender = {
      includes = [ 
        aspects.legacy
        aspects.raspberry-pi-5
      ];
      nixos = {
        imports = [
          ../../hosts/ender/configuration.nix
        ];
      };
    };
  };
}
