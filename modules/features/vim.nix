{ ... }:
{
  flake.aspects =
    { ... }:
    {
      vim = {
        homeManager =
          { pkgs, ... }:
          {
            programs.vim = {
              enable = true;
              plugins = with pkgs.vimPlugins; [
                catppuccin-vim
              ];
              settings = {
                number = true;
                shiftwidth = 2;
                expandtab = true;
                mouse = "a";
                background = "dark";
              };
              extraConfig = ''
                set termguicolors
                set showtabline=2
                set cursorline
                set laststatus=0

                colorscheme catppuccin_frappe

                " mappings
                nnoremap <silent> <C-n> :tabnew<CR>
                nnoremap <silent> <C-Left> :tabprevious<CR>
                nnoremap <silent> <C-Right> :tabnext<CR>
              '';
            };
          };
      };
    };
}
