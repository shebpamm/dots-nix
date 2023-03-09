{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    python39
  ];
}
