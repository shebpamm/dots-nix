{ pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      github.copilot-chat

      asvetliakov.vscode-neovim

      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      bbenoist.nix
    ];
    userSettings = {
      "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;
      "keyboard.dispatch" = "keyCode";
      "workbench.colorTheme" = "Catppuccin Mocha";
    };
  };
  home.file.".config/Code - Insiders".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/Code";
  home.file.".vscode-insiders".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.vscode";
}
