#!/bin/zsh

echo Updating container...
pacman -Syu --noconfirm

packages=${*:-
	metatorrent
	gimmeasearx
	lokinet
	firefox-userchromejs
	firefox-keyconfig
	firefox-vimfx
	firefox-ytarb
	firefox-dark-reader
	firefox-sponsorblock
	firefox-ublock-origin
	lsb-release
	wlroots
	wf-config
	wayfire
	wlogout
	waybar
	wdisplays
	emmet-cli
	neo
	kakoune
	up
	kampliment
	qwerty-lafayette
	iwgtk
	vim-lsp
	vim-lsp-settings
	vim-asyncomplete
	vim-asyncomplete-lsp
	vim-vsnip
	vim-vsnip-integ
	vim-fzf
	vim-repeat
	vim-devicons
	vim-submode
}
pgpkeys=(
# Haden Collins <collinshaden@gmail.com> (wlogout)
F4FDB18A9937358364B276E9E25D679AF73C6D2F
# Raymond Hill <rhill@raymondhill.net> (firefox-ublock-origin)
603B28AA5D6CD687A554347425E1490B761470C2
)

useradd -s/bin/sh -mG wheel builder 2>/dev/null
sed -i 's/# \(%wheel ALL=(ALL:ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers
pacman-key --init 2>/dev/null
pacman-key --populate archlinux 2>/dev/null
su builder -c "$(cat <<EOF
for key in ${pgpkeys[*]}; do
	echo Importing key \$key...
	gpg --recv-keys \$key
done
for pkg in ${packages[*]}; do
	echo Building package \$pkg...
	pushd "/root/\$pkg" >/dev/null
	yes "" | makepkg -scfi || exit 1
	mv *pkg.tar* /home/builder
	popd >/dev/null
done
EOF
)"

