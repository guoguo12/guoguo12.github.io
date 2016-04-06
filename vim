set nocompatible
syntax on
"color evening
set wildmenu
set showcmd
set hlsearch
set incsearch 
set ignorecase
set smartcase
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set nostartofline
set ruler
set nu
set laststatus=2
set confirm
set mouse=a
set showmatch 

set autoindent
set shiftwidth=4
set softtabstop=4
set expandtab
"set shiftwidth=2
"set tabstop=2

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set splitright

" // in visual mode to search for visually selected string
vnoremap // y/<C-R>"<CR>

" From http://vim.wikia.com/wiki/Short_mappings_for_common_tasks
vmap > >gv
vmap < <gv
nnoremap Q @q
nmap <Space> /
nmap <C-Space> ?
imap <up> <C-O>gk
imap <down> <C-O>gj
nmap <up> gk
nmap <down> gj
vmap <up> gk
vmap <down> gj
