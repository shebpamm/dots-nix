{ ... }:
{
  flake.aspects =
    { ... }:
    {
      system-base = {
        nixos =
          { ... }:
          {
            environment.sessionVariables = {
              PATH = [
                "\$HOME/.krew/bin"
                "\$XDG_BIN_HOME"
                "\$HOME/.node_modules"
                "\$HOME/.cache/npm/bin"
              ];
            };
          };
        homeManager = { ... }: { };
      };
    };
}
