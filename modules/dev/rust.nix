{ config, pkgs, libs, ... }:
{
  home.packages = [ 
    pkgs.cargo
    pkgs.rust-analyzer
  ];
  home.sessionVariables = {
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
  };
  home.sessionPath = [ "$CARGO_HOME/bin" ];
}
