{ config, ... }:
{
  perSystem =
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
