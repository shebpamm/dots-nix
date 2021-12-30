{ config, pkgs, libs, ... }:
{
  programs.kitty.settings = {
    background = "#282c34";
    foreground = "#abb2bf";
    selection_background = "#abb2bf";
    selection_foreground = "#282c34";
    url_color = "#565c64";
    cursor = "#abb2bf";
    active_border_color = "#545862";
    inactive_border_color = "#353b45";
    active_tab_background = "#282c34";
    active_tab_foreground = "#abb2bf";
    inactive_tab_background = "#1b1d23";
    inactive_tab_foreground = "#565c64";
    tab_bar_background = "#282c34";

    color0 = "#282c34";
    color1 = "#e06c75";
    color2 = "#98c379";
    color3 = "#e5c07b";
    color4 = "#61afef";
    color5 = "#c678dd";
    color6 = "#56b6c2";
    color7 = "#abb2bf";
    color8 = "#5c6370";
    color9 = "#d19a66";
    color10 = "#353b45";
    color11 = "#3e4451";
    color12 = "#565c64";
    color13 = "#b6bdca";
    color14 = "#be5046";
    color15 = "#c8ccd4";
  };
}
