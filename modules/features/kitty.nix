{ ... }:
{
  flake.aspects =
    { ... }:
    {
      kitty =
        let
          colors = {
            foreground = "#C6D0F5";
            background = "#303446";
            selection_foreground = "#303446";
            selection_background = "#F2D5CF";

            cursor = "#F2D5CF";
            cursor_text_color = "#303446";

            url_color = "#F2D5CF";

            active_border_color = "#BABBF1";
            inactive_border_color = "#737994";
            bell_border_color = "#E5C890";

            wayland_titlebar_color = "system";
            macos_titlebar_color = "system";

            active_tab_foreground = "#232634";
            active_tab_background = "#CA9EE6";
            inactive_tab_foreground = "#C6D0F5";
            inactive_tab_background = "#292C3C";
            tab_bar_background = "#232634";

            mark1_foreground = "#303446";
            mark1_background = "#BABBF1";
            mark2_foreground = "#303446";
            mark2_background = "#CA9EE6";
            mark3_foreground = "#303446";
            mark3_background = "#85C1DC";

            color0 = "#51576D";
            color8 = "#626880";

            color1 = "#E78284";
            color9 = "#E78284";

            color2 = "#A6D189";
            color10 = "#A6D189";

            color3 = "#E5C890";
            color11 = "#E5C890";

            color4 = "#8CAAEE";
            color12 = "#8CAAEE";

            color5 = "#F4B8E4";
            color13 = "#F4B8E4";

            color6 = "#81C8BE";
            color14 = "#81C8BE";

            color7 = "#B5BFE2";
            color15 = "#A5ADCE";
          };
        in
        {
          nixos = { ... }: { };
          homeManager =
            { ... }:
            {
              programs.kitty = {
                enable = true;
                font = {
                  name = "Fira Code Regular";
                  size = 12;
                };
                settings = {
                  cursor_shape = "underline";
                  window_padding_width = 15;
                  scrollback_lines = 5000;
                  tab_bar_style = "fade";
                  tab_fade = 1;
                  tab_bar_margin_width = 5;
                  tab_bar_margin_height = 5;
                  allow_remote_control = "yes";
                  listen_on = "unix:/tmp/kitty";
                }
                // colors;
                extraConfig = ''
                  bold_font Fira Code Bold
                  disable_ligatures never
                  strip_trailing_spaces smart
                  enable_audio_bell no
                  symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E62F,U+E700-U+E7C5,U+F000-U+F2E0,U+F300-U+F31C,U+F400-U+F4A9,U+F500-U+F8FF 3270 Nerd Font
                  symbol_map U+E800,U+E801,U+E802 karstakuvakkeet
                  confirm_os_window_close 0
                '';
              };
            };
        };
    };
}
