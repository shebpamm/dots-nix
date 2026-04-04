{ config, pkgs, libs, inputs, ... }:
{
  home.packages = with pkgs; [
    spotify-player
  ];
  programs.spicetify = {
    enable = true;
    theme = pkgs.spicetifyPackages.themes.catppuccin;
  };

  services.spotifyd.enable = true;
  services.spotifyd.settings.global = {
    username = "shebpamm";
    password_cmd = "cat /run/secrets/spotify-password";
    use_mpris = true;
    device_name = "hexane";
    device_type = "computer";
  };
}
