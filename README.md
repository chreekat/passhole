# A hole for your passwords: your passhole

Based on incredibly complex schemes for safely editing gpg-encrypted files in
vim, this just does the simplest thing that possibly (occasionally) works.

1. Define a filetype **.hole* for passwords
1. Disallows writing any data or metadata out to disk
2. Hardcodes which PGP key to use for crypto (lol)
3. Assumes you use gpg-agent or similar to avoid using the tty for passphrase
   entry

In order to write your files, you must specify your recipients (your selves,
generally speaking) in the List g:passhole_recipients.

```vim
" in file ~/.vim/after/plugin/passhole.vim, or whatever floats your boat
let g:passhole_recipients = ["0xdeadbeef"]
```

\<insert GPL disclaimer and Copyright 2017 here>
