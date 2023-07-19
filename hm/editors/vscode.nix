{ pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.vscode-insider;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      github.copilot-chat
      asvetliakov.vscode-neovim
    ];
    userSettings = {
      "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;
    };
  };
  home.file.".config/Code - Insiders".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/Code";
  home.file.".vscode-insiders.source" = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.vscode";
}
