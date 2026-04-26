{ pkgs, ... }:
{
  home.packages = with pkgs; [
    timewarrior
    taskwarrior2
  ];
}
