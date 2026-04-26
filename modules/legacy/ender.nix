{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      ender = {
        includes = [
          aspects.legacy
        ];
        nixos = {
          imports = [
            ../../hosts/ender/configuration.nix
          ];
        };
      };
    };
}
