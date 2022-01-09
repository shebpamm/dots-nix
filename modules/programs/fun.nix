{ config, pkgs, libs, ... }:
{ 
  #Collection of random small packages with no real use
  home.packages = with pkgs; [
    cmatrix
    lolcat
    pipes-rs
  ];
}
