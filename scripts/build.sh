#!/bin/sh
git submodule update --init
sed -i 's#<packages>#'"$(pwd)"/packages'#' pacman.conf
# unmount all stuff inside work/
IFS=$'\n'; for m in $(findmnt -ao TARGET | cut -d- -f2- | grep "$PWD"); do
umount -l "$m" 2>/dev/null
done
rm -rf work && \
# gotta patch mkarchiso to insert source /usr/src
sed '5s/^/set -- -v -w work -o out .\n/;/Copying custom airootfs files.../{n;a\
	git config --global --add safe.directory "$profile"\
	_msg_info "Copying source to /usr/src..."\
	mkdir -p "$pacstrap_dir/usr/src/demolinux"\
	rsync --exclude-from=<(git -C "$profile" ls-files -oi --exclude-standard --directory) -Eav --chown=root:root -- "$profile"/* "$pacstrap_dir/usr/src/demolinux"\
	_msg_info "Copying local packages..."\
	mkdir "$pacstrap_dir"/packages\
	cp "$profile"/packages/{*.zst,packages.*} "$pacstrap_dir/packages"
}' `which mkarchiso` | bash
# for ease of understandability
sed -i 's#'"$(pwd)"/packages'#<packages>#' pacman.conf
chown -R 1000:1000 out
