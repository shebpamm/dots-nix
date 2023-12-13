{ config, pkgs, libs, ... }:
let
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        (wee-slack.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "shebpamm";
            repo = "wee-slack";
            rev = "master";
            sha256 = "sha256-kyklM5Y53RphtKU3gmouGu8UN2EqEsDJD0iGk724BM8=";
          };
        }))
        weechat-autosort
        colorize_nicks
      ];
    };
  };
in
{
  home.packages = [
    weechat
  ];
}
