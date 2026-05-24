{ ... }:
{
  flake.aspects =
    { ... }:
    {
      shell-utils = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              dyff
              eza
              fd
              htop
              hyperfine
              jq
              socat
              unzip
              websocat
              yq-go
              erdtree
              fzf
              ncdu
              zoxide
              wget
            ];
          };
      };
    };
}
