{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    timewarrior
    taskwarrior
  ];
}
