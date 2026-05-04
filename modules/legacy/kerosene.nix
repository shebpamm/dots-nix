{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [ aspects.legacy ];
        homeManager = {
          imports = [
            ../../hm/shell
            ../../hm/editors/vscode.nix
            ../../hm/editors/vim.nix
            ../../hm/programs
            ../../hm/programs/graphics.nix
          ];
        };
      };
    };
}
