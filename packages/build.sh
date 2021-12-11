#!/bin/sh

ensure_installed() {
	return $(pacman -Q $1 >/dev/null 2>&1) || \
		echo "missing $1, exiting" && exit 1
}

ensure_installed arch-install-scripts
ensure_installed git

if [ ! -d container ]; then
	rm -rf container
	mkdir container
	pacstrap -c container base base-devel
fi
systemd-nspawn -D container \
	--bind="$(pwd)"/tobuild:/root /root/script.sh

