{ config, pkgs, libs, ... }:
{
  programs.kitty.settings = {
    foreground = "#4C4F69";
    background = "#EFF1F5";
    selection_foreground = "#EFF1F5";
    selection_background = "#DC8A78";

    cursor = "#DC8A78";
    cursor_text_color = "#EFF1F5";

    url_color = "#DC8A78";

    active_border_color = "#7287FD";
    inactive_border_color = "#9CA0B0";
    bell_border_color = "#DF8E1D";

    wayland_titlebar_color = "system";
    macos_titlebar_color = "system";

    active_tab_foreground = "#EFF1F5";
    active_tab_background = "#8839EF";
    inactive_tab_foreground = "#4C4F69";
    inactive_tab_background = "#9CA0B0";
    tab_bar_background = "#BCC0CC";

    mark1_foreground = "#EFF1F5";
    mark1_background = "#7287fD";
    mark2_foreground = "#EFF1F5";
    mark2_background = "#8839EF";
    mark3_foreground = "#EFF1F5";
    mark3_background = "#209FB5";

    color0 = "#5C5F77";
    color8 = "#6C6F85";

    color1 = "#D20F39";
    color9 = "#D20F39";

    color2 = "#40A02B";
    color10 = "#40A02B";

    color3 = "#DF8E1D";
    color11 = "#DF8E1D";

    color4 = "#1E66F5";
    color12 = "#1E66F5";

    color5 = "#EA76CB";
    color13 = "#EA76CB";

    color6 = "#179299";
    color14 = "#179299";

    color7 = "#ACB0BE";
    color15 = "#BCC0CC";

  };
}
