{ config, pkgs, libs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    extraPackages = with pkgs; [
      nodePackages.prettier_d_slim
      nodePackages.typescript-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-css-languageserver-bin
      shellcheck
      sqlfluff
      stylua
      tfsec
      yamlfmt
      yamllint
      gopls
      tflint
      terraform-ls
      taplo
      sqls
      dot-language-server
      ansible-language-server
    ];
    extraPython3Packages = ppkgs: with ppkgs; [
      black
      isort
      flake8
      pydocstyle
    ];
  };
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
}
