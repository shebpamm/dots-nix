{ config, pkgs, ... }:
{
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\$HOME/.cache";
    XDG_CONFIG_HOME = "\$HOME/.config";
    XDG_BIN_HOME = "\$HOME/.local/bin";
    XDG_DATA_HOME = "\$HOME/.local/share";
    EDITOR = "nvim";

    PATH = [
      "\$HOME/.bin"
      "\$HOME/.krew/bin"
      "\$XDG_BIN_HOME"
      "\$HOME/.node_modules"
      "\$HOME/.cache/npm/bin"
    ];
  };
}
