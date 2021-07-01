#!/usr/bin/expect -f

set timeout 2
set master_login
set master_pwd
set master_ip
set master_ip_static
set git_login "$env(GIT_LOGIN)\n"
set git_pwd "$env(GIT_PASSWORD)\n"

set server "$master_login@$master_ip"
set password "$master_pwd"

#подключение к ноде
spawn ssh $server
# ожидание запроса пароля и ввод его
expect {
 -re {password: $} {send "$password\r"}
 timeout {error "ssh connection timed out!"}
}

 expect \"*$\"

 send "sudo -s \r"

 expect "* password:"
 send "$master_pwd\r"

 expect \"*#\"

 send "sed -ie '$ a export GIT_LOGIN=$git_login' /.bashrc \r"
 expect \"*#\"

 send "sed -ie '$ a export GIT_PASSWORD=$git_pwd' /.bashrc \r"
 expect \"*#\"

send "sed -ie '$ a export NODE_PWD=$master_pwd' .bashrc \r"
 expect \"*#\"

send "sed -ie '$ a export NODE_IP=$master_ip_static' /.bashrc \r"
 expect \"*#\"

send "apt install expect -y \r"
 expect \"root@*#\"

 send "export TMP_HOME=`pwd` \r"
 expect \"*#\"

 send "git clone https://github.com/kir0108/master-init /master-init\r"
 expect \"*#\"

 send "sh /master-init/swapoff-script.sh &\r"
 expect \"*#\"
