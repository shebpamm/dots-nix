{ inputs, ... }:
{
  flake-file.inputs.claude.url = "github:shebpamm/claude-nix";

  flake.aspects =
    { ... }:
    {
      claude = {
        homeManager =
          { ... }:
          {
            imports = [ inputs.claude.homeModules.default ];

            wrappers.claude-code = {
              enable = true;
              kubernetes.enable = false;
              grafana.enable = false;
            };
          };
      };
    };
}
