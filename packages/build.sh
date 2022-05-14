#!/bin/sh

ensure_installed() {
	pacman -Q $1 >/dev/null 2>&1
	[ $? -ne 1 ] || \
		( echo "missing $1, exiting"; kill $$ )
}

ensure_installed archiso
ensure_installed arch-install-scripts
ensure_installed git

# check whether the container has been created properly
if [ ! -d container/etc ]; then
	rm -rf container
	mkdir container
	pacstrap -c container base base-devel
fi
systemd-nspawn -D container \
	--bind="$(pwd)"/tobuild:/root /root/script.sh $@

