augroup pass_filetype
    autocmd!
    autocmd BufReadCmd *.pass call passhole#read_afile()
    autocmd BufWriteCmd *.pass call passhole#write_afile()
augroup END
