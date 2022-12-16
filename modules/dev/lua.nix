{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    lua
    lua52Packages.luarocks
    stylua
    sumneko-lua-language-server
  ];
}
