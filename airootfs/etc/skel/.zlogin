if [ `tty` = /dev/tty1 ]; then
	[ $((`tput cols` >= 120)) ] && cat /etc/motd
	info Hacking NSA...
	infon "Set a password \x1b[0m(or press return for an empty one): " && read -s pw
	[ -n "$pw" ] && passwd >/dev/null 2>&1 <<EOP
$pw
$pw
EOP
	infot Starting Wayfire %3s...\
	"\n\x1b[0mPress ^C to cancel                                  "
	wayfire >.wayfire.log 2>&1
fi

