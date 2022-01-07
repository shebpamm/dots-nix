{ config, pkgs, libs, ... }:
let
    themedSpotify = pkgs.spotify-spiced {
          theme = "Sleek";
          colorScheme = "nord";
          injectCss = true;
          replaceColors = true;
          overwriteAssets = true;
        };
in { home.packages = [ themedSpotify ]; }
