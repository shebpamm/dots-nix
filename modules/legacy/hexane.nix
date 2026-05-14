{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [ aspects.legacy ];
        homeManager = {
          imports = [
            ../../hm/editors/vscode.nix
            ../../hm/programs
            ../../hm/programs/graphics.nix
            ../../hm/programs/work.nix
            ../../hm/shell
          ];
        };
      };
    };
}
