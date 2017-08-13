function passhole#read_afile()
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

    setfiletype hole

    setl noundofile
    setl noswapfile
    set viminfo=

    setl foldmethod=marker foldlevel=0
    setl foldopen=insert
    setl commentstring=\ %s
endfunction

function passhole#write_afile()
    silent write !gpg --yes -se -q -r 0x20068bfb --armor --output <afile>
    if ! v:shell_error
        setl nomodified
    endif
endfunction
