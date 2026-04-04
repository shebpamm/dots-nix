{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos { system = "x86_64-linux"; name = "hexane"; };
  # flake.homeConfigurations = inputs.self.lib.mkHomeManager { system = "x86_64-linux"; name = "hexane"; };
}
