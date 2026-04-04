{ ... }:
{
  flake.aspects = { aspects, ... }: {
    hexane = {
      includes = [ aspects.legacy ];
      nixos = {
        imports = [
          ../../hosts/hexane/configuration.nix
        ];
      };
    };
  };
}
