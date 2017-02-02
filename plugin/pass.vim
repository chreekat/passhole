if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

augroup pass_filetype
    autocmd!
    autocmd BufReadCmd *.pass call passhole#read_afile()
    autocmd BufWriteCmd *.pass call passhole#write_afile()
augroup END

function s:read_afile()
    silent 0read ++edit !gpg -d -q --output - <afile> 2>/dev/null

    " Dance with undolevels to clear history. See :help 'clear-undo'
    " 
    let ul = &undolevels
    set undolevels=-1
    keepjumps $delete _
    " ^ Remove the final newline, which also clears history (??)
    keepjumps 0
    let &undolevels = ul
    unlet ul

    setlocal noundofile
    setlocal noswapfile
    set viminfo=
endfunction

function s:write_afile()
    silent write !gpg --yes -se -q -r chreekat --armor --output <afile>
    setl nomodified
endfunction
