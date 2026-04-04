{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ aspects.legacy ];
      nixos = {
        imports = [
          ../../hosts/kerosene/configuration.nix
        ];
      };
      homeManager = {
        imports = [
          {
            home = {
              homeDirectory = "/home/shebpamm";
              username = "shebpamm";
              stateVersion = "23.11";
            };

            programs.home-manager.enable = true;
          }

          ../../hm/system/clipcat.nix
          ../../hm/shell
          ../../hm/shell/ssh.nix
          ../../hm/editors/neovim.nix
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
