#!/usr/bin/expect -f

set timeout 5
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

 send "export NODE_PWD=$master_pwd\r"

 expect \"*$\"

 send "sudo -s \r"
 expect "password:"

 send "$master_pwd\r"

 expect \"*#\"

 send "sed -i '$ a export NODE_PWD=$master_pwd' .bashrc \r"
 expect \"*#\"

 send "cd /\r"
 expect \"*#\"

 send "git clone https://github.com/kir0108/master-init\r"
 expect \"*#\"

 send "cp /master-init/rc.local /etc\r"
 expect \"*#\"

 send "export GIT_LOGIN=$git_login\r"
 expect \"*#\"

 send "export GIT_PASSWORD=$git_pwd\r"
 expect \"*#\"

 send "export NODE_IP=$master_ip_static\r"
 expect \"*#\"

 send "sed -i '$ a export GIT_LOGIN=$git_login' /root/.bashrc \r"
 expect \"*#\"

 send "sed -i '$ a export GIT_PASSWORD=$git_pwd' /root/.bashrc \r"
 expect \"*#\"

 send "sed -i '$ a export NODE_IP=$master_ip_static' /root/.bashrc \r"
 expect \"*#\"

 send "sed -i '$ a export GIT_LOGIN=$git_login' /etc/rc.local \r"
 expect \"*#\"

 send "sed -i '$ a export GIT_PASSWORD=$git_pwd' /etc/rc.local \r"
 expect \"*#\"

 send "sed -i '$ a export NODE_IP=$master_ip_static' /etc/rc.local \r"
 expect \"*#\"

 set timeout 20

 send "apt install expect -y \r"
 expect \"root@*\"

 set timeout -1

 send "sh /master-init/swapoff-script.sh \r"
 expect \"*#\"
