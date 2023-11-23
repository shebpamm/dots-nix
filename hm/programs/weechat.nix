{ config, pkgs, libs, ... }:
let
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        wee-slack
        weechat-autosort
      ];
    };
  };
in
{
  home.packages = [
    weechat
  ];
}
