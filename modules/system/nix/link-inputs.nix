# This is mostly taken from flake-utils-plus
# https://github.com/gytis-ivaskevicius/flake-utils-plus/blob/afcb15b845e74ac5e998358709b2b5fe42a948d1/lib/options.nix#L14
# Since the module wants inputs as a specialArg, just copy the logic here
{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      nix = {
        nixos =
          { lib, ... }:
          let
            inherit (lib) filterAttrs mapAttrs';

            flakes = filterAttrs (_name: value: value ? outputs) inputs;

            nixRegistry = builtins.mapAttrs (_name: v: { flake = v; }) flakes;
          in
          {
            nix.registry = nixRegistry;

            nixpkgs.flake = {
              setFlakeRegistry = false;
              setNixPath = false;
            };

            environment.etc = (
              mapAttrs' (name: value: {
                name = "nix/inputs/${name}";
                value = {
                  source = value.outPath;
                };
              }) inputs
            );

            nix.nixPath = [ "/etc/nix/inputs" ];
          };
      };
    };
}
