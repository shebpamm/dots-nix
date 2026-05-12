{ inputs, ... }:
{
  flake-file.inputs.wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  flake-file.inputs.wrappers.inputs.nixpkgs.follows = "nixpkgs";

  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];
}
