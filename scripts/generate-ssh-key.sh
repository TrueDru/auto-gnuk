#!/usr/bin/expect -f
set timeout -1
spawn gpg --card-edit
send -- "admin\r"
send -- "generate\r"
send -- "quit\r"
expect eof