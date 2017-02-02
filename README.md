# A hole for your passwords: your passhole

Based on incredibly complex schemes for safely editing gpg-encrypted files in
vim, this just does the simplest thing that possibly (occasionally) works.

1. Define a filetype *\*.pass* for passwords
2. Relies on buffer-specific or global config to specify your encryptionk ey
3. Assumes you use gpg-agent or similar to avoid using the tty for passphrase
   entry
