#!/bin/zsh

pgpkeys=(
# ArchZFS Bot <buildbot@archzfs.com>
DDF7DB817396A49B2A2723F7403BD972F75D9D76
)

for key in ${pgpkeys[*]}; do
	pacman-key --recv-keys $key
	pacman-key --lsign-key $key
done

