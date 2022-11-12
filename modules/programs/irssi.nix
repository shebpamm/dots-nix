{ config, pkgs, libs, ... }:
{
  programs.irssi = {
    enable = true;
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
          nixos.autoJoin = true;
        };
        # saslExternal = true;
      };
    };
  };
}
