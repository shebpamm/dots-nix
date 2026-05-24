{
  inputs,
  ...
}:
{
  # setup of tools for dendritic pattern

  # Simplify Nix Flakes with the module system
  # https://github.com/hercules-ci/flake-parts

  # Generate flake.nix from module options.
  # https://github.com/denful/flake-file

  # Import all nix files in a directory tree.
  # https://github.com/denful/import-tree

  flake-file.inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.group = "dendritic";
    flake-file.url = "github:denful/flake-file";
    flake-file.group = "dendritic";
    flake-aspects.url = "github:denful/flake-aspects";
    flake-aspects.group = "dendritic";
    import-tree.url = "github:denful/import-tree";
    import-tree.group = "dendritic";
  };

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
    inputs.flake-aspects.flakeModule
  ];

  # import all modules recursively with import-tree
  flake-file.outputs = ''
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  '';

  # set flake.systems
  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-darwin"
    "x86_64-linux"
  ];
}
