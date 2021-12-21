set nocompatible
syntax enable
filetype plugin indent on

" tab stuff -- commented out since installing sleuth
" set autoindent
" set smartindent
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" set expandtab
" autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
" autocmd Filetype ansible setlocal ts=2 sw=2 expandtab
" autocmd Filetype python setlocal ts=4 sw=4 expandtab

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
Plug 'preservim/tagbar'
Plug 'morhetz/gruvbox'
Plug 'ekalinin/Dockerfile.vim'
Plug 'romainl/Apprentice'
Plug 'towolf/vim-helm'
Plug 'neovim/nvim-lspconfig'
call plug#end()

set ttyfast
set et
set nobackup
set comments=b:#,:%,fb:-,n:>,n:)
set noerrorbells
set ignorecase
set smartcase
set modelines=0
" set backspace=indent,eol,start
filetype on " enable filetype detection
set tags=tags;/
set mouse=a
set autoread
set autoindent
set rtp+=/usr/local/opt/fzf
set undofile
set undodir=~/.vim/undodir

" Editor looks
"

set laststatus=2
set ruler
set number
set title
set scrolloff=3
set sidescrolloff=5
set incsearch
set hlsearch
set termguicolors
let g:lightline = { 'colorscheme': 'wombat' }
" let g:gruvbox_invert_selection=0
colorscheme apprentice
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set cursorline
set noshowmode
set showcmd
set listchars=tab:▸\ ,eol:¬
set list
" set updatetime=100 " for async git gutter updates
" let g:signify_sign_add    = '┃'
" let g:signify_sign_change = '┃'
" let g:signify_sign_delete = '•'

" let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines.
let g:fzf_preview_window = []

" Keyboard mappings
" let mapleader = ","
let mapleader = "\<Space>"
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <leader>p :set paste!<CR>
" nnoremap <F6> :set list!<CR>
nnoremap <leader>r :set relativenumber!<CR>
nnoremap <C-x> :bnext<CR>
nnoremap <leader>l :setlocal listchars=space:.,tab:▸\ ,eol:¬<CR>
nnoremap <leader>n :setlocal listchars=tab:▸\ ,eol:¬<CR>

" cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" sort visually hilighted lines
map <leader>s :sort<CR>
map Y y$
nmap <leader>t :TagbarToggle<CR>
nmap <leader>b :BTags<CR>
vmap <leader>y "*y

" python stuff
let g:python_host_prog  = '/Users/sjahl/.pyenv/shims/python2'
let g:python3_host_prog = 'Users/sjahl/.pyenv/shims/python3'

" lsp stuff
"
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local servers = {'terraformls', 'gopls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
  on_attach = on_attach,
}
end
EOF

" terraform stuff
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting()
