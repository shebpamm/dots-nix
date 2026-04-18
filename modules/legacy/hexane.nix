{ inputs, ... }:
{
  flake.aspects = { aspects, ... }: {
    hexane = {
      includes = [ aspects.legacy ];
      nixos = {
        imports = [
          ../../hosts/hexane/configuration.nix
        ];
      };
      homeManager = {
        imports = [
          ../../hm/desktop
          ../../hm/desktop/windowManagers/awesome.nix
          ../../hm/dev
          ../../hm/editors/neovim.nix
          ../../hm/editors/vim.nix
          ../../hm/editors/vscode.nix
          ../../hm/system/clipcat.nix
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
