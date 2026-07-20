{ inputs, lib, ... }:
{
  # Helper functions for creating system / home-manager configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  # compatability layer for home-manager,
  # without this hm does not allow multiple definitions of the attribute
  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = { };
  };

  options.flake.terraformConfigurations = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = { };
  };

  config.flake-file.inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";
  };

  config.flake.lib = {

    mkNixos =
      {
        system,
        name,
        nixosSystem ? inputs.nixpkgs.lib.nixosSystem,
        specialArgs ? { },
      }:
      {
        ${name} = nixosSystem {
          modules = [
            inputs.self.modules.nixos.${name}
            {
              nixpkgs.hostPlatform = lib.mkDefault system;
              nixpkgs.config.allowUnfree = true;
            }
          ];

          # Don't use this unless strictly required by an external module
          inherit specialArgs;
        };
      };

    mkDarwin =
      { system, name }:
      {
        ${name} = inputs.nix-darwin.lib.darwinSystem {
          modules = [
            inputs.self.modules.darwin.${name}
            { nixpkgs.hostPlatform = lib.mkDefault system; }
          ];
        };
      };

    mkHomeManager =
      { system, name }:
      {
        ${name} = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          modules = [
            inputs.self.modules.homeManager.${name}
            { nixpkgs.config.allowUnfree = true; }
          ];
        };
      };

    mkTerraform =
      { system, name }:
      {
        ${name} = inputs.terranix.lib.terranixConfiguration {
          inherit system;
          extraArgs = { inherit name; };
          modules = [
            inputs.self.modules.terraform.${name}
          ];
        };
      };

  };
}
