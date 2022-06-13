{ config, pkgs, libs, ... }:
  let
    pythonEnv = (pkgs.python39.withPackages (ps: [
      ps.pip
      ps.openai

    ])).override (args: { ignoreCollisions = true; });
  in {
    home.packages = with pkgs; [
      pythonEnv
      poetry
      nodePackages.pyright
    ];
  }
