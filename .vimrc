" Vundle begin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Themes
Plugin 'altercation/vim-colors-solarized'
Plugin 'rakr/vim-one'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'rdnetto/YCM-Generator'
Plugin 'tpope/vim-fugitive'
Plugin 'Chiel92/vim-autoformat'
" Plugin 'yuttie/comfortable-motion.vim'
" Plugin 'Yggdroot/indentLine'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Vundle end





" Basic part
" Tab settings
set tabstop=2
set expandtab
set shiftwidth=0

" Line number
set number
" Enable relative line number
set rnu
" Enable cursor line
set cursorline
" Enable indent
set cindent
" Column limit
set colorcolumn=80

" Highlight searching
set hlsearch
" Highlight matching angle brackets
set matchpairs+=<:>
" Enable syntax highlighting
syntax enable

" File encoding
" set fileencodings=utf-8,gbk,utf-16,big5,gb18030,latin1

" Backspace setting
set backspace=indent,eol,start



" Custom key binding
" Search and highlight but do not jump
" nnoremap * :keepjumps normal! *``<cr>
" TODO: For some reason, `` didn't work as expected"?
nnoremap *  :keepjumps normal! mi*`i<CR>

" Window navigation
" nnoremap <Leader>1  :1 wincmd w<CR>
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

" Switch between Source/Header file
nnoremap <Leader>jc :e %:r.cpp<CR>
nnoremap <Leader>jh :e %:r.h<CR>



" Theme Settings
" True color support
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
" For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Basic Theme
" set t_Co=256
" autocmd ColorScheme * hi SignColumn ctermbg=none
" autocmd ColorScheme * hi VertSplit ctermbg=none
autocmd ColorScheme * hi YcmErrorSection cterm=underline
autocmd ColorScheme * hi YcmWarningSection cterm=underline
set signcolumn=no
set background=dark
colorscheme one

" Enable italic font
" TODO: Seems long way to go
" let g:one_allow_italics = 1

" For vim-airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='one'

" For tmuxline
let g:tmuxline_preset={
    \'a'       : '#H',
    \'win'     : ['#I', '#W'],
    \'cwin'    : ['#I', '#W'],
    \'x'       : '#(/home/yang/.local/bin/tmux-mem-cpu-load -m 2 -a 0 --interval 2)',
    \'y'       : '%R',
    \'z'       : '%Y-%m-%d',
    \'options' : {'status-justify' : 'left'}}



" For Fzf
set rtp+=/usr/local/opt/fzf
nnoremap <Leader><C-f> :Files<CR>
nnoremap <Leader><C-l> :Buffers<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
"
" Default options are --nogroup --column --color
let s:ag_options = '-u --smart-case'
" Search with options
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 s:ag_options,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Fzf end



" For Ycm
let g:ycm_confirm_extra_conf = 0
let g:ycm_use_clangd = 1
let g:ycm_always_populate_location_list = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
set completeopt-=preview
" Key binding for ycm command
nnoremap <Leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>ydd :YcmShowDetailedDiagnostic<CR>



" For NERDTree
let g:NERDTreeWinSize=20



" For vim-autoformat
let g:formatdef_my_cpp_formatter = "'clang-format -style=\"{BasedOnStyle: google, SortIncludes: false}\" -lines='.a:firstline.':'.a:lastline"
let g:formatters_cpp = ['my_cpp_formatter']
nnoremap <Leader>af :Autoformat<CR>
