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
            ../../hm/dev
            ../../hm/programs
            ../../hm/programs/graphics.nix
            ../../hm/desktop
            ../../hm/desktop/windowManagers/awesome.nix
          ];
        };
      };
    };
}
