syntax enable
set number
set mouse=a
set hlsearch
set ignorecase
set smartcase

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set list

cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev QA qa
cnoreabbrev Wq wq
cnoreabbrev WQ wq

" source $HOME/.config/nvim/coc.vimrc
" source $HOME/.config/nvim/netrw.vimrc

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:semshi#simplify_markup = v:false
au BufRead,BufNewFile *.ebnf set filetype=tatsu

call plug#begin()
    Plug 'vim-airline/vim-airline'
    Plug 'sheerun/vim-polyglot'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'

    Plug 'numirias/semshi'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'

    Plug 'hrsh7th/vim-vsnip'
    Plug 'ray-x/lsp_signature.nvim'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-ui-select.nvim'

    Plug 'michaeljsmith/vim-indent-object'
    Plug 'scrooloose/nerdtree'
    Plug 'glench/vim-jinja2-syntax'

call plug#end()

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Always show sign column, so it doesn't pop in and out
set signcolumn=yes


" Set correct color scheme and fix semshi's awful awful colors
set termguicolors
colorscheme monokai_ad

hi semshiSelected cterm=underline gui=underline
hi semshiGlobal  guifg=#abfdf2
hi semshiImported guifg=#abfdf2 gui=italic
hi semshiParameter guifg=#ffffff
hi semshiParameterUnused guifg=#ffffff
" hi semshiParameterUnused guifg=#87d7ff gui=italic
hi semshiBuiltin guifg=#78dce8 gui=italic
hi semshiAttribute guifg=#ffffff
hi semshiSelf guifg=#ab9df2
hi semshiSelf guifg=#78dce8
hi link pythonBuiltin Builtin

hi semshiFree            ctermfg=218 guifg=#ffafd7
hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
" hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f


lua require('config')

