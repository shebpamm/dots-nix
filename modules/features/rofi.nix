{ ... }:
{
  flake.aspects =
    { ... }:
    {
      rofi = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, config, ... }:
          {
            home.packages = with pkgs; [
              rofi
            ];

            home.file.".config/rofi/config.rasi".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi/config.rasi";

            home.file.".local/share/rofi/themes".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi/themes";
          };
      };
    };
}
