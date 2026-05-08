{ inputs, ... }:
{

  flake-file.inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    programs = {
      # Actions
      actionlint.enable = true;

      # Nix
      deadnix.enable = true;
      nixfmt.enable = true;

      # Golang
      gofmt.enable = true;
      golangci-lint.enable = true;

      # JavaScript / TypeScript
      oxfmt.enable = true;

      # Python
      ruff-check.enable = true;
      ruff-format.enable = true;

      # Rust
      rustfmt.enable = true;

      # Bash
      shellcheck.enable = true;
      shfmt.enable = true;

      # Terraform
      terraform.enable = true;
      hclfmt.enable = true;

      # YAML
      yamllint.enable = true;
      yamlfmt.enable = true;

      # Misc
      dockerfmt.enable = true; # Dockerfiles
      fish_indent.enable = true; # Fish
      mdformat.enable = true; # Markdown
      rubocop.enable = true; # Ruby
      sqlfluff.enable = true; # SQL
      stylua.enable = true; # Lua
      taplo.enable = true; # TOML
    };
    settings.excludes = [
      "node_modules/*"
      "secrets/*.yaml"
      "Cargo.nix"
    ];
  };

  flake.aspects.treefmt = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ inputs.self.formatter.${pkgs.stdenv.hostPlatform.system} ];
      };
  };
}
