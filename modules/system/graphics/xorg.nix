{ ... }:
{
  flake.aspects =
    { ... }:
    {
      xorg = {
        nixos =
          { ... }:
          {
            services.libinput.enable = true;
            services.xserver = {
              enable = true;
              displayManager.lightdm = {
                enable = true;
              };

              deviceSection = ''
                Option "ModeValidation" "AllowNonEdidModes"
              '';

              xkb.layout = "eu";
              xkb.options = "caps:escape";
            };
            programs.dconf.enable = true;
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              libnotify
              dunst
              wmctrl
              xdotool
              xprintidle
              arandr
              (xsecurelock.overrideAttrs (oldAttrs: {
                buildInputs = oldAttrs.buildInputs ++ [ mplayer ];
                configureFlags = oldAttrs.configureFlags ++ [ "--with-mplayer=${mplayer}/bin/mplayer" ];
              }))
            ];
          };
      };
    };
}
