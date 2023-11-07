{ config, pkgs, libs, inputs, ... }:
{
  imports = [ inputs.spicetify.homeManagerModule ];
  home.packages = with pkgs; [
    spotify-player
  ];
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
    in
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
      ];
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
