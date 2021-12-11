#!/bin/sh
test -n "$1" || {
	echo "missing file to download" && exit 1
}
test -n "$2" || {
	echo "missing output file" && exit 2
}
sed -i '/\[localhost\]:60022/d' ~/.ssh/known_hosts
sshpass -p $PASSWORD ssh-copy-id -o StrictHostKeyChecking=no -p60022 demostanis@localhost >/dev/null
scp -P60022 ${@:3} demostanis@localhost:"$1" "$2"
