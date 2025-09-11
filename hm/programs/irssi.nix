{ config, pkgs, libs, ... }:
{
  programs.irssi = {
    enable = false;
    networks = {
      liberachat = {
        nick = "shebpamm";
        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
          ssl = {
            enable = true;
            certificateFile = /run/secrets/shebpamm-libera.crt;
          };
        };
        channels = {
          # nixos.autoJoin = true;
        };
      };
      oftc = {
        nick = "shebpamm";
        server = {
          address = "irc.oftc.net";
          port = 6697;
          autoConnect = true;
          ssl = {
            enable = true;
            certificateFile = /run/secrets/shebpamm-libera.crt;
          };
        };
      };
    };
    extraConfig = ''
    '';
  };
  home.file.".irssi/scripts".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/irssi/scripts";

  home.file.".irssi/screwer-redux.theme".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/irssi/screwer-redux.theme";
}
