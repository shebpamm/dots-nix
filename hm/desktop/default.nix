{ config, pkgs, libs, ... }:
{
  imports = [
    # ./picom.nix
    ./compfy.nix
    ./gtk.nix
  ];
  home.packages = with pkgs; [
    tint2
  ];
  home.file.".config/tint2".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tint2";

  home.file.".config/dunst".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/dunst";

  home.file.".config/rofi/config.rasi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi/config.rasi";

  home.file.".config/eww".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/eww";

  home.file.".local/share/rofi/themes".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi/themes";

  home.file.".config/wofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/wofi";
}
