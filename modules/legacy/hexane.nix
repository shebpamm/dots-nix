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
          {
            programs.ssh.matchBlocks."*".extraOptions = { IdentityAgent = "~/.1password/agent.sock"; };
            home.sessionVariables.SSH_AUTH_SOCK = "${inputs.self.context.homeDirectory}/.1password/agent.sock";
          }
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
