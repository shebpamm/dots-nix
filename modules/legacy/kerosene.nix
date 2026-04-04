{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ aspects.legacy ];
      nixos = {
        imports = [
          ../../hosts/kerosene/configuration.nix
        ];
      };
    };
  };
}
