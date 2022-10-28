#!/bin/sh
git submodule update --init
sed -i 's#<packages>#'"$(pwd)"/packages'#' pacman.conf
# unmount all stuff inside work/
IFS=$'\n'; for m in $(findmnt -ao TARGET | cut -d- -f2- | grep "$PWD"); do
umount -l "$m" 2>/dev/null
done
rm -rf work && \
# gotta patch mkarchiso to insert source /usr/src and to install blackarch
sed '5s/^/set -- -v -w work -o out .\n/;/Copying custom airootfs files.../{n;a\
	git config --global --add safe.directory "$profile"\
	_msg_info "Copying source to /usr/src..."\
	mkdir -p "$pacstrap_dir/usr/src/demolinux"\
	rsync --exclude-from=<(git -C "$profile" ls-files -oi --exclude-standard --directory) -Eav --chown=root:root -- "$profile"/* "$pacstrap_dir/usr/src/demolinux"\
	_msg_info "Copying local packages..."\
	mkdir "$pacstrap_dir"/packages\
	cp "$profile"/packages/{*.zst,packages.*} "$pacstrap_dir/packages"
};/_make_customize_airootfs/{n;n;a\
	keyring_file=blackarch-keyring.pkg.tar.xz\
	_msg_info "Downloading $keyring_file..."\
	curl -Os https://blackarch.org/keyring/$keyring_file{,.sig} -O\
	trap "rm $keyring_file{,.sig}" EXIT\
	_msg_info "Importing PGP key..."\
	# Evan Teitelman <teitelmanevan@gmail.com>\
	key=4345771566D76038C7FEB43863EC0ADBEA87E4E3\
	pacman-key --init\
	pacman-key -r $key\
	pacman-key --lsign-key $key\
	_msg_info "Installing blackarch-keyring..."\
	pacman -r "$pacstrap_dir" -U $keyring_file\
	_msg_info "Downloading blackarch-mirrorlist..."\
	curl -o "$pacstrap_dir"/etc/pacman.d/blackarch-mirrorlist https://blackarch.org/blackarch-mirrorlist\
	sed -i "/# Worldwide/,/^$/s/^#S/S/p" "$pacstrap_dir"/etc/pacman.d/blackarch-mirrorlist\
	cat <<EOF >> "$pacstrap_dir"/etc/pacman.conf\
\
[blackarch]\
Include = /etc/pacman.d/blackarch-mirrorlist\
EOF
}' `which mkarchiso` | bash
# for ease of understandability
sed -i 's#'"$(pwd)"/packages'#<packages>#' pacman.conf
chown -R 1000:1000 out
