{ inputs, ... }:
{
  flake-file.inputs.neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

  flake.aspects =
    { ... }:
    {
      neovim = {
        nixos =
          { ... }:
          {
            environment.sessionVariables.EDITOR = "nvim";
          };
        homeManager =
          { pkgs, config, ... }:
          let
            extras = with pkgs; [
              ansible-lint
              clang-tools
              dot-language-server
              gopls
              haskellPackages.haskell-language-server
              dockerfile-language-server
              prettier
              prettierd
              typescript-language-server
              vscode-langservers-extracted
              ty
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
              nixd
              bash-language-server
              yaml-language-server
              shfmt
              astyle
              tree-sitter
            ];
            python-extras = with pkgs.python314Packages; [
              black
              isort
              flake8
              pydocstyle
            ];

          in
          {
            nixpkgs.overlays = [ inputs.neovim-nightly.overlays.default ];

            programs.neovim = {
              enable = true;
              defaultEditor = true;
              withPython3 = true;
              withNodeJs = true;
              withRuby = true;
              sideloadInitLua = true; # We just symlink our config, skip writing init.lua
              extraPackages = extras ++ python-extras;
              extraPython3Packages = (
                ps: with ps; [
                  python-dotenv
                  requests
                  pynvim
                  prompt-toolkit
                ]
              );
            };
            home.file.".config/nvim".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
          };
      };
    };
}
