{ inputs, ... }:
{
  flake-file.inputs.disko.url = "github:nix-community/disko";

  flake.aspects =
    { ... }:
    {
      system-base = {
        nixos =
          { ... }:
          {
            imports = [ inputs.disko.nixosModules.disko ];
          };
      };
    };
}
