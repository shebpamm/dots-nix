{ ... }:
{
  flake.aspects =
    { ... }:
    {
      lua = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              lua
              lua52Packages.luarocks
              lua-language-server
            ];
          };
      };
    };
}
