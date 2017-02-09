augroup passhole_filetype
    autocmd!
    autocmd BufReadCmd *.hole call passhole#read_afile()
    autocmd BufWriteCmd *.hole call passhole#write_afile()
augroup END
