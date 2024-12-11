{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python311
    ansible-lint
  ];
}
