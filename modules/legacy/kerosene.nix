{ inputs, ...}:
{
  flake.modules.nixos.kerosene = {
    imports = [
      # external modules are imported here until legacy modules are refactored
      inputs.sops-nix.nixosModules.sops
      inputs.disko.nixosModules.disko

      # common legacy modules, eg. overlays
      inputs.self.modules.nixos.legacy

      ../../hosts/kerosene/configuration.nix
    ];
  };
}
