{ config, pkgs, libs, ... }:
{
  imports = [ ./colors/catppuccin/frappe.nix ];

  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code Regular";
      size = 11;
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
    };
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
}
