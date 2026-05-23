{ ... }:
{
  flake.aspects =
    { ... }:
    {
      wezterm = {
        homeManager =
          { pkgs, config, ... }:
          {
            home.packages = with pkgs; [
              wezterm
            ];

            home.file.".config/wezterm".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/wezterm";
          };
      };
    };
}
