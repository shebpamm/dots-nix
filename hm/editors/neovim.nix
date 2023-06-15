{ config, pkgs, libs, ... }:
let
  extras = with pkgs; [
    nodePackages.prettier_d_slim
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-css-languageserver-bin
    nodePackages.pyright
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
  python-extras = with pkgs.python39Packages; [
    black
    isort
    flake8
    pydocstyle
  ];

in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    extraPackages = extras ++ python-extras;
  };
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
}
