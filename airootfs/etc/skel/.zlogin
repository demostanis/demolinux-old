# small hack to get the bar
# only to display on my laptop
# (hide it from my second display)
if [ -e /sys/class/drm/card0-LVDS-1 ]; then
	sed -i 's/\/\/ To be later on modified/"output": "LVDS-1",/' ~/.config/waybar/config
fi

if [ `tty` = /dev/tty1 ]; then
	[ $((`tput cols` >= 120)) ] && cat /etc/motd
	info Hacking NSA...
	info Loading dconf settings... && \
	if [ ! -e ~/.config/dconf ]; then
		dconf load / < ~/.config/default-dconf
		rm ~/.config/default-dconf
	fi
	info Synchronizing clock with NTP... && timedatectl set-ntp true

	infon "Set a password \x1b[0m(or press return for an empty one): " && read -s pw
	[ -n "$pw" ] && passwd >/dev/null 2>&1 <<EOP
$pw
$pw
EOP
	infot Starting Wayfire %3s...\
	"\n\x1b[0mPress ^C to cancel                                  "
	wayfire >.wayfire.log 2>&1
fi

