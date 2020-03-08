call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat'
Plug 'itchyny/vim-cursorword'
Plug 'rhysd/accelerated-jk'
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jkramer/vim-checkbox'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

set nocompatible
" Force me to use keyboard
" set mouse=a
set number
set cursorline
set scrolloff=2

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

map <Leader><A-f> :Files<CR>
map <Leader>f :GFiles<CR>
map <Leader>g :Rg<CR>
map <Leader>v :Vista!!<CR>
map <C-o> :NERDTreeToggle<CR>
map <C-A-l> :Neoformat<CR>
imap jk <Esc>
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
map <Leader>s <Plug>(easymotion-s2)
vnoremap s <Plug>(easymotion-s2)

" Theme
let base16colorspace=256
colorscheme base16-default-dark

" Airline
let g:airline_powerline_fonts = 1

" Coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
nnoremap <a-cr> :CocAction <CR>

" Vista
let g:vista_icon_indent = ["▸ ", ""]
let g:vista_default_executive = 'coc'

" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

"NERDTree
let g:NERDTreeMouseMode=3 

"put this in your .vimrc
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,__pycache__

"Nerdtree config for wildignore
let NERDTreeRespectWildIgnore=1


lua require'colorizer'.setup()
