{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [ aspects.legacy ];
        homeManager = {
          imports = [
            ../../hm/desktop
            ../../hm/desktop/windowManagers/awesome.nix
            ../../hm/dev
            ../../hm/editors/vim.nix
            ../../hm/editors/vscode.nix
            ../../hm/programs
            ../../hm/programs/graphics.nix
            ../../hm/programs/xorg.nix
            ../../hm/programs/work.nix
            ../../hm/shell
          ];
        };
      };
    };
}
