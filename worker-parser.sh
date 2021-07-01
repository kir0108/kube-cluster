#!/bin/bash

export m_login=$(jq ".worker.login" config.json)
export m_pwd=$(jq ".worker.pwd" config.json)
export m_d=$(jq ".worker.dynamic_ip" config.json)
export m_s=$(jq ".worker.static_ip" config.json)

sed -i "4 s/$/ $m_login/" worker-connect.sh
sed -i "5 s/$/ $m_pwd/" worker-connect.sh
sed -i "6 s/$/ $m_d/" worker-connect.sh
sed -i "7 s/$/ $m_s/" worker-connect.sh
