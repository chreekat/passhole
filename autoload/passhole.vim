function! passhole#read_afile()
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

    " Auto close after 3 minutes. We don't have a swap file, so modifying
    " updatetime has no other effect.
    let &l:updatetime = 3 * 60 * 1000
    " NB!!!! Nest this autocmd so that write_afile actually gets run. You lose
    " your passhole otherwise (total data loss ftw. It's only happened twice to
    " me so far....)
    au CursorHold <buffer> nested q

    " Yank a password
    nnoremap <buffer> <F5> "+yiW
endfunction

function! s:foldMap1(mappend, map, xs)
    if len(a:xs) == 0
        throw "passhole#foldMap1: List must be non-empty"
    endif
    let ms = map(copy(a:xs), a:map)
    let acc = ms[0]
    for v in ms[1:]
        let acc = a:mappend(acc, v)
    endfor
    return acc
endfunction

function! passhole#write_afile()
    if exists('g:passhole_recipients')
        let afile = expand("<afile>")
        let keyArgs = s:foldMap1({a, b -> a . ' ' . b}, {k, v -> '-r ' . v}, g:passhole_recipients)
        let emsg = execute(printf("write !gpg --yes -se -q %s --armor --output %s", l:keyArgs, l:afile))
        if ! v:shell_error
            setl nomodified
        else
            echoe emsg
        endif
    else
        echoerr "You must specify g:passhole_recipients (a List of GPG keys) to write this buffer!"
    endif
endfunction
