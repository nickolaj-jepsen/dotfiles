call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'sbdchd/neoformat'
Plug 'itchyny/vim-cursorword'
Plug 'rhysd/accelerated-jk'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'famiu/feline.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

Plug 'lewis6991/gitsigns.nvim'


call plug#end()

set nocompatible
" Force me to use keyboard
" set mouse=a
set number
set cursorline
set scrolloff=2

set clipboard=unnamedplus
set splitbelow

" Colors
execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"
set termguicolors

filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=4
set expandtab

nmap <space> <leader>

map <Leader><A-f> <cmd>Telescope find_files<cr>
map <Leader>f <cmd>Telescope git_files<cr>
map <Leader>g <cmd>Telescope live_grep<cr>
map <C-o> :NERDTreeToggle<CR>
map <C-p> :Neoformat<CR>
imap jk <Esc>
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
map <Leader>s <Plug>(easymotion-s2)
vnoremap s <Plug>(easymotion-s2)

" Theme
let base16colorspace=256
colorscheme base16-default-dark

" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

"NERDTree
let g:NERDTreeMouseMode=3 
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,__pycache__
let NERDTreeRespectWildIgnore=1

lua require'colorizer'.setup()

"feline
lua require('feline').setup()

"gitsigns
lua require('gitsigns').setup()

"LSPconfig
lua require('lspconfig').tsserver.setup{}
lua require('lspconfig').pylsp.setup{}

"nvim-cmp
lua <<EOF
local cmp = require'cmp'
cmp.setup {
   formatting = {
      format = function(entry, vim_item)
         -- load lspkind icons
         vim_item.kind = string.format(
            "%s %s",
            require("plugins.configs.lspkind_icons").icons[vim_item.kind],
            vim_item.kind
         )

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
         })[entry.source.name]

         return vim_item
      end,
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = function(fallback)
         if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
         else
            fallback()
         end
      end,
      ["<S-Tab>"] = function(fallback)
         if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
         else
            fallback()
         end
      end,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "nvim_lua" },
   },
}
EOF

