{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    system = "aarch64-linux";
    name = "ender";
    nixosSystem = inputs.nixos-raspberrypi.lib.nixosSystem;

    # raspberrypi flake requires itself to be in specialArgs
    specialArgs = {
      nixos-raspberrypi = inputs.nixos-raspberrypi;
    };
  };

  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    system = "aarch64-linux";
    name = "ender";
  };
}
