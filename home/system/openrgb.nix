{ config, pkgs, libs, ... }:
{
  systemd.user.services.openrgb = {
    Unit = {
      Description = "Headless OpenRGB Server";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
        ExecStart = "${pkgs.openrgb}/bin/openrgb --server -p default";
        Restart = "on-failure";
    };
  };

  home.packages = [ pkgs.openrgb ];

  home.file.".config/OpenRGB/OpenRGB.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/openrgb/OpenRGB.json";
  home.file.".config/OpenRGB/default.orp".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/openrgb/default.orp";
}
