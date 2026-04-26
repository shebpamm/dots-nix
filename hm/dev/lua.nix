{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lua
    lua52Packages.luarocks
    lua-language-server
  ];
}
