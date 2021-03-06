"execute pathogen#infect()
"let g:nerdtree_tabs_open_on_console_startup=1
set number
set nocompatible              " be iMproved, required
filetype on                 " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    Plugin 'tpope/vim-fugitive'
    " plugin from http://vim-scripts.org/vim/scripts.html
    Plugin 'L9'
    " Git plugin not hosted on GitHub
    Plugin 'git://git.wincent.com/command-t.git'
    " git repos on your local machine (i.e. when working on your own plugin)
    "Plugin 'file:///home/gmarik/path/to/plugin'
    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    " Avoid a name conflict with L9
    "Plugin 'user/L9', {'name': 'newL9'}
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'scrooloose/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    Plugin 'rdnetto/YCM-Generator'
    Plugin 'octol/vim-cpp-enhanced-highlight'

    " Track the engine.
    Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'f-squirrel/vim-snippets'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    "Plugin 'bling/vim-bufferline'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'junegunn/vim-easy-align'
    Plugin 'altercation/vim-colors-solarized.git'
    Plugin 'jiangmiao/auto-pairs.git'
    Plugin 'flazz/vim-colorschemes'
    Plugin 'ntpeters/vim-better-whitespace'
    Plugin 'fatih/vim-go'
    Bundle 'schickling/vim-bufonly'
    Plugin 'vim-syntastic/syntastic'
    "Plugin 'bbchung/clighter'
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

" This file is usually symbolic link to file with code style relevant for
" current company
source ~/.vim/.code_style.vim
colorscheme wombat

"let g:rehash256 = 1

function SetColumnGuideLine()
    "Highlight current line
    "set cursorline
    highlight ColorColumn ctermbg=darkgray
    "Highligt max line length
    set colorcolumn=144
endfunction

function GetOperatingSystemName()
    return substitute(system('uname'), "\n", "", "")
endfunction

function SetNerdTree()
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " close vim in case only open window is NerdTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeShowHidden=1
    let g:NERDTreeIgnore = ['\.pyc$', '\.DS_Store', '\.swp', '\.swn', '\.swo']
    let g:NERDTreeWinPos = "left"
    let g:NERDTreeWinSize=30
    set modifiable "to have possibility to add/remove files from NERD Tree menu

    map <C-n> :NERDTreeToggle<CR>
endfunction

function SetYouCompleteMe()
    "Turns off youCompleteMe
    "let g:loaded_youcompleteme = 1
    let g:ycm_collect_identifiers_from_tags_files=1

    if GetOperatingSystemName() == "Darwin"
        let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
        if isdirectory(s:clang_library_path)
            let g:clang_library_path=s:clang_library_path
        endif
    elseif GetOperatingSystemName() == "Linux"
        " Do Linux-specific stuff.
        " ...
    endif
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_key_list_select_completion = ['<Down>']
    let g:ycm_key_list_previous_completion = ['<Up>']
    let g:ycm_use_ultisnips_completer = 1

    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    "let g:UltiSnipsExpandTrigger="<tab>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

    map <C-G> :YcmCompleter GoToDeclaration<CR>
endfunction

" ============================================================================================================================================

"for Clighter
"let g:clighter_autostart = 1
"let g:clighter_libclang_file = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
set pastetoggle=<F2>

function SetVimAirLine()
    set laststatus=2
    se t_Co=256
    let g:airline_theme='dark'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
endfunction

function SetCommandT()
    "Sometimes we deal with really big projects...
    let g:CommandTSuppressMaxFilesWarning=1
    "Use binary native find to increase speed
    let g:CommandTFileScanner = 'find'
endfunction

function SetEasyAlignMappings()
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
endfunction

function SetBufferSwitchingMappings()
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    nnoremap <S-Left> :bprev<CR>
    nnoremap <S-Right> :bnext<CR>
endfunction

function SetSearchMappings()
    "Select visually text and press // to start search
    vnoremap // y/<C-R>"<CR>
    "Double ESC turns off highlight of search results

    nnoremap <esc><esc> :noh<return>
endfunction
"Delete all trailing spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"enable mouse
"set mouse=a

"Mappings for mouse-toggle plugin
"https://github.com/nvie/vim-togglemouse
noremap <F11> :call <SID>ToggleMouse()<CR>
inoremap <F11> <Esc>:call <SID>ToggleMouse()<CR>a

set shell=/bin/bash

let mapleader=","

call SetBufferSwitchingMappings()
call SetColumnGuideLine()
call SetEasyAlignMappings()
call SetNerdTree()
call SetVimAirLine()
call SetYouCompleteMe()
call SetCommandT()
call SetSearchMappings()

" Set shady colors for NerdTree
if( GetOperatingSystemName() == "Linux" )
    hi Directory guifg=#FF0000 ctermfg=blue
endif

