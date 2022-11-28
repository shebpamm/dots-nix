" my .vimrc

" bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

set termguicolors
set background=dark
colorscheme catppuccin_frappe

set number
set showtabline=2
set cursorline
set shiftwidth=2
set expandtab
set laststatus=0
set mouse=a

" mappings
nnoremap <silent> <C-n> :tabnew<CR>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
