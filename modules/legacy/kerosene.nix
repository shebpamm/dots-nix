{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [ aspects.legacy ];
        nixos = {
          imports = [
            ../../hosts/kerosene/configuration.nix
          ];
        };
        homeManager = {
          imports = [
            ../../hm/system/clipcat.nix
            ../../hm/shell
            ../../hm/editors/vscode.nix
            ../../hm/editors/vim.nix
            ../../hm/dev
            ../../hm/programs
            ../../hm/programs/xorg.nix
            ../../hm/programs/graphics.nix
            ../../hm/desktop
            ../../hm/desktop/windowManagers/awesome.nix
          ];
        };
      };
    };
}
