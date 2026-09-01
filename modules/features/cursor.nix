{ inputs, ... }:
{
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";
  flake-file.inputs.llm-agents.group = "ai";

  flake.aspects =
    { ... }:
    {
      cursor = {
        homeManager =
          { pkgs, ... }:
          {
            programs.cursor.enable = true;
            home.packages = [
              inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.cursor-agent
            ];
          };
      };
    };
}
