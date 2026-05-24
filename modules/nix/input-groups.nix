{ config, lib, ... }:
{
  options.flake-file.inputs = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options = {
          group = lib.mkOption {
            default = "";
            type = lib.types.str;
            description = "The input group this input belongs to.";
          };
        };
      }
    );
  };
  config.perSystem =
    { pkgs, ... }:
    {
      apps.list-inputs =
        let
          inputsFile = pkgs.writeText "inputs.json" (builtins.toJSON config.flake-file.inputs);
        in
        {
          type = "app";
          program = pkgs.writeShellApplication {
            name = "list-inputs";
            text = ''
              ${pkgs.jq}/bin/jq . ${inputsFile}
            '';
          };
        };
    };
}
