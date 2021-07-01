#!/usr/bin/expect -f

set SUDO_PASS "777" "777" "777" "777" "777" "777" "777" "777" "777"
spawn sudo -s
expect {
"sudo" {
send "$SUDO_PASS\r"
exp_continue
}
}
