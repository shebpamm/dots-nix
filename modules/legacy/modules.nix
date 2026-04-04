{ inputs, ... }:
{
  flake.aspects = {
    legacy = {
      nixos = {
        imports = [
          # external modules are imported here until legacy modules are refactored
          inputs.sops-nix.nixosModules.sops
          inputs.disko.nixosModules.disko
        ];
      };
    };
  };
}
