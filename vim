" Basics
set nocompatible
set nobackup
syntax on
"color zellner

" Set leader
let mapleader = ","
let maplocalleader = ",,"

" Customizations
set wildmenu wildmode=longest:list,full      " Match completion
set showcmd                                  " Command hint in corner
set hlsearch incsearch ignorecase smartcase  " Improved search
set backspace=indent,eol,start               " Fix backspace in certain terminals
set whichwrap+=<,>,h,l,[,]                   " Allow movement to wrap
set nostartofline ruler number               " Improved handling of lines
set laststatus=2                             " Always show a status line
set confirm                                  " Ask about saving files
set mouse=a                                  " Enable mouse for all modes
set showmatch                                " Highlight matching brace when inserting
set splitright                               " When splitting, new window goes on right
set hidden                                   " Allow hidden buffers

" Indentation
set autoindent
set expandtab shiftwidth=4 softtabstop=4
"set shiftwidth=2 tabstop=2

" Save information between sessions
set vi=%,'50 
set vi+=\"100,:100 
set vi+=n~/.viminfo 

" Register filetypes
au! BufNewFile,BufRead *.md set filetype=markdown

" Filetype-specific settings
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/<C-R>"<CR>

" http://vim.wikia.com/wiki/Short_mappings_for_common_tasks
vmap > >gv     " Right indent in visual
vmap < <gv     " Left indent in visual
nnoremap Q @q  " Q to use macro recorded with qq
nnoremap Y y$  " Y to yank until end-of-line (similar to D)

" Move up/down by display lines when wrapping
imap <up> <C-O>gk
imap <down> <C-O>gj
nmap <up> gk
nmap <down> gj
vmap <up> gk
vmap <down> gj

" Move around windows easily
map <S-up> <esc><C-w><Up>
map <S-down> <esc><C-w><Down>
map <S-left> <esc><C-w><Left>
map <S-right> <esc><C-w><Right>
imap <S-up> <esc><C-w><Up>
imap <S-down> <esc><C-w><Down>
imap <S-left> <esc><C-w><Left>
imap <S-right> <esc><C-w><Right>

" Move around tabs easily
map <C-P> :tabp<cr>
map <C-N> :tabn<cr>
nnoremap <S-left> :tabp<cr>
nnoremap <S-right> :tabn<cr>

" Map _ and - to ^ and $
nnoremap _ ^
nnoremap - $
onoremap _ ^
onoremap - $

" Search easily
nmap <space> /
nmap <C-space> ?

" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
:highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:match ExtraWhitespace /\s\+$/

" http://superuser.com/questions/286985/reload-vimrc-in-vim-without-restart
map <leader>vimrc :vsp ~/.vimrc<cr>
autocmd bufwritepost .vimrc source $MYVIMRC

" Custom bindings
map <leader>m :set nonumber mouse-=a<cr>          " Turn off mouse (for copy/paste)
map <leader>M :set number mouse=a<cr>             " Turn on mouse
map <leader>c :set colorcolumn=80<cr>             " Turn on line length guide
map <leader>C :set colorcolumn=0<cr>              " Turn off line length guide
nnoremap K i<cr><Esc>                             " Undo J
map <F2> :e %:h<cr>                               " Show directory containing file
set pastetoggle=<F4>                              " Toggle paste mode
map <F5> :GundoToggle<cr>                         " Toggle Gundo
nmap <F8> :setlocal invspell spelllang=en_us<cr>  " Toggle spelling mode
map <F12> :nohlsearch<cr>                         " Clear search highlighting
