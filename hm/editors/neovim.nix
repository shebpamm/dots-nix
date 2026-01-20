{ config, pkgs, libs, ... }:
let
  extras = with pkgs; [
    ansible-lint
    clang-tools
    dot-language-server
    gopls
    haskellPackages.haskell-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.prettier_d_slim
    nodePackages.typescript-language-server
    vscode-langservers-extracted
    pyright
    ruff
    shellcheck
    sqlfluff
    sqls
    stylish-haskell
    stylua
    taplo
    terraform-ls
    tflint
    tfsec
    yamlfmt
    yamllint
    bash-language-server
    yaml-language-server
    shfmt
  ];
  python-extras = with pkgs.python314Packages; [
    black
    isort
    flake8
    pydocstyle
  ];

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    extraPackages = extras ++ python-extras;
    extraPython3Packages = (ps: with ps; [
      python-dotenv
      requests
      pynvim
      prompt-toolkit
    ]);
  };
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
}
