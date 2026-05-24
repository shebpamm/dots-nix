{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    system = "x86_64-linux";
    name = "homestack";
  };

  flake.terraformConfigurations = inputs.self.lib.mkTerraform {
    system = "x86_64-linux";
    name = "homestack";
  };
}
