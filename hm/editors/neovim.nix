{ config, pkgs, libs, ... }:
let
  extras = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.prettier_d_slim
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
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
    clang-tools
    stylish-haskell
    haskellPackages.haskell-language-server
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
