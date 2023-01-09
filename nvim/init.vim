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

" python stuff
let g:python_host_prog  = expand('~/.virtualenvs/nvim27/bin/python')
let g:python3_host_prog = expand('~/.virtualenvs/nvim/bin/python')

call plug#begin('~/.config/nvim/plugged')
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
Plug 'preservim/nerdtree'
Plug 'ekalinin/Dockerfile.vim'
Plug 'romainl/Apprentice'
Plug 'towolf/vim-helm'
Plug 'neovim/nvim-lspconfig'
Plug 'sainnhe/everforest'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()

set ttyfast
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
set undodir=~/.config/nvim/undodir
set clipboard+=unnamedplus

" Editor looks

set laststatus=2
set ruler
set number
set relativenumber
set title
set scrolloff=3
set sidescrolloff=5
set incsearch
set hlsearch
set termguicolors
set background=dark

lua << EOF
require("tokyonight").setup({
  styles = {
    functions = { italic = false },
    keywords = { italic = false },
    }
})
EOF

let g:lightline = { 'colorscheme': 'tokyonight' }
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
colorscheme tokyonight

" if $ITERM_PROFILE == "Atom One Light"
"   set background=light
"   let g:lightline = { 'colorscheme': 'one' }
"   colorscheme mac_classic
" elseif $ITERM_PROFILE == "Base16 Default Dark"
"   set background=dark
"   let g:lightline = { 'colorscheme': 'everforest' }
"   let g:everforest_background = 'hard'
"   colorscheme everforest
" endif

set cursorline
set noshowmode
set showcmd
set listchars=tab:▸\ ,eol:¬
set list

" set updatetime=100 " for async git gutter updates
let g:gitgutter_sign_added    = '┃'
let g:gitgutter_sign_modified = '┃'
" let g:signify_sign_delete = '•'

let g:fzf_preview_window = []

" Keyboard mappings
let mapleader = ","

" This is how I had space mapped, in case I ever want to do that again
" let mapleader = "\<Space>"

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <leader>p :set paste!<CR>
" nnoremap <F6> :set list!<CR>
nnoremap <leader>r :set relativenumber!<CR>
nnoremap <C-x> :bnext<CR>
nnoremap <leader>l :setlocal listchars=space:.,tab:▸\ ,eol:¬<CR>
" nnoremap <leader>n :setlocal listchars=tab:▸\ ,eol:¬<CR>

nnoremap <leader>f :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" sort visually hilighted lines
map <leader>s :sort<CR>
map Y y$
nmap <leader>t :TagbarToggle<CR>
nmap <leader>b :BTags<CR>
" vmap <leader>y "+y

" lightline stuff
function! s:set_lightline_colorscheme(name) abort
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! s:lightline_colorschemes(...) abort
  return join(map(
        \ globpath(&rtp,"autoload/lightline/colorscheme/*.vim",1,1),
        \ "fnamemodify(v:val,':t:r')"),
        \ "\n")
endfunction

command! -nargs=1 -complete=custom,s:lightline_colorschemes LightlineColorscheme
      \ call s:set_lightline_colorscheme(<q-args>)

"lsp stuff

lua << EOF
local nvim_lsp = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
      vim.diagnostic.disable(bufnr)
      vim.defer_fn(function()
        vim.diagnostic.reset(nil, bufnr)
      end, 1000)
  end
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f',function() vim.lsp.buf.format { async = true } end, bufopts)
end

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['terraformls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['yamlls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
        },
        validate = true,
        hover = true,
        completion = true,
        format = { enable = true },
      },
    }
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "go", "terraform", "lua", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

EOF
