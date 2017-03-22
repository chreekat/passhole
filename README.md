# A hole for your passwords: your passhole

Based on incredibly complex schemes for safely editing gpg-encrypted files in
vim, this just does the simplest thing that possibly (occasionally) works.

1. Define a filetype **.hole* for passwords
1. Disallows writing any data or metadata out to disk
2. Hardcodes which PGP key to use for crypto (lol)
3. Assumes you use gpg-agent or similar to avoid using the tty for passphrase
   entry

\<insert GPL disclaimer and Copyright 2017 here>
