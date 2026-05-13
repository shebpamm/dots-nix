{ inputs, config, ... }:
{
  perSystem = { pkgs, ... }: {
    apps.list-inputs =
      let
        inputsFile = pkgs.writeText "inputs.txt" <| builtins.concatStringsSep "\n" <| builtins.attrNames config.flake-file.inputs;
      in
      {
        type = "app";
        program = pkgs.writeShellApplication {
          name = "list-inputs";
          text = ''
            cat ${inputsFile}
          '';
        };
      };
  };
}
