" Inspired by...: https://www.pedaldrivenprogramming.com/2018/03/line-by-line-simple-usable-vim/
" Also check out: https://vimconfig.com/

                    " Indentation
set expandtab 	    "  Tabs are spaces
set shiftwidth=2    "  Size of indents in spaces
set softtabstop=2   "  Simulate tabs with this many spaces
                    " Line numbers and mouse
set number          "  Enable line numbers
set mouse=a         "  Enable mouse in auto mode
                    " Searching
set incsearch       "  Don't wait for the enter key to start searching
set hlsearch        "  Highlight search results
                    " Syntax and colors
syntax enable       "  Turn on syntax highlighting
colorscheme slate   "  Use the slate theme
                    " Strip trailing whitespace
                    " Miscelaneous
set wildmenu        "  Show tab completions for commands inline
                    "  Files to ignore for various auto completion commands
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,__pycache__,node_modules
nnoremap d          "  Remap the dd shortcut to not nuke whatever was in the yank buffer
vnoremap d          "

fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace() " Call TrimWhitespace on save

