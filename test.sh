#!/bin/bash

export m_login=$(jq ".master.login" config.json)
export m_pwd=$(jq ".master.pwd" config.json)
export m_d=$(jq ".master.dynamic_ip" config.json)
export m_s=$(jq ".master.static_ip" config.json)

sed -i "4 s/$/ $m_login/" master-connect.sh
sed -i "5 s/$/ $m_pwd/" master-connect.sh
sed -i "6 s/$/ $m_d/" master-connect.sh
sed -i "7 s/$/ $m_s/" master-connect.sh
