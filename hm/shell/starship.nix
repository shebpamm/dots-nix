{ config, pkgs, ... }:
{
  programs.starship.enable = false;
  programs.starship.settings = {
    add_newline = true;
    aws.disabled = false;
    aws.format = "on [$symbol($profile)]($style) ";
    aws.style = "bold yellow";
    aws.symbol = "☁️ ";
  };
}
