# small hack to get the bar
# only to display on my laptop
# (hide it from my second display)
if [ -e /sys/class/drm/card0-LVDS-1 ]; then
	sed -i 's/\/\/ To be later on modified/"output": "LVDS-1",/' ~/.config/waybar/config
fi

if [ `tty` = /dev/tty1 ]; then
	[ $((`tput cols` >= 120)) ] && cat /etc/motd
	info Hacking NSA...

	wf() { wayfire >.wayfire.log 2>&1 }

	keyfile=$(mktemp)
	# we have to use a temporary file here
	# because $() prevents infot from reading STDIN...
	# or whatever is wrong. i hate zsh now
	infot Starting Wayfire %3s...\
	"\n\x1b[0mPress ^C to cancel" >$keyfile
	s=$?
	key=$(<$keyfile); rm -f $keyfile
	(( s != 0 )) && return

	# we use asteriks here since $key might (mysteriously) contain newlines
	case $key in
		*" "*|*p*)
			infon "\x1b[2K\x1b[1A\x1b[2K\x1b[1ASet a password \x1b[0m(or press return for an empty one): " && read -s pw
			[ -n "$pw" ] && passwd >/dev/null 2>&1 <<EOP
$pw
$pw
EOP
			wf
			;;
		*)
			wf
			;;
	esac
fi
