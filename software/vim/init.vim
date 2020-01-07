" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'valloric/youcompleteme'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'
Plug 'altercation/vim-colors-solarized'
Plug 'flazz/vim-colorschemes'
Plug 'kergoth/vim-bitbake'

call plug#end()

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Show line numbers
set nu
" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

syntax enable
set background=dark
colorscheme Benokai
" colorscheme subtle_light

" Add shortcut for NERDTree toggle (Ctrl+n)
map <C-n> :NERDTreeToggle<CR>
" Open files in new tab
let NERDTreeMapOpenInTab='<ENTER>'

set colorcolumn=80
" Copy to clipboard by default
set clipboard+=unnamedplus

let g:airline_powerline_fonts = 1

" cscope config
if has("cscope")
        " Look for a 'cscope.out' file starting from the current directory,
        " going up to the root directory.
        let s:dirs = split(getcwd(), "/")
        while s:dirs != []
                let s:path = "/" . join(s:dirs, "/")
                if (filereadable(s:path . "/cscope.out"))
                        execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
                        break
                endif
                let s:dirs = s:dirs[:-2]
        endwhile

        set csto=0	" Use cscope first, then ctags
        set cst		" Only search cscope
        set csverb	" Make cs verbose

        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

        " Open a quickfix window for the following queries.
        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
endif

" Make pylint use python3
let g:pymode_python = 'python3'
