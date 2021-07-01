#!/usr/bin/expect -f

set timeout 2

 send "sed -ie '$ s/$/export GIT_LOGIN=123/' .bashrc"
