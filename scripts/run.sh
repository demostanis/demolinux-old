#!/bin/zsh
f=`mktemp /tmp/XXXXXXXrun_archiso`
sed 's/-vga virtio/-vga cirrus/' `which run_archiso` > $f
[ -n "$UEFI" ] && flags=u
sh $f -${flags}i out/*.iso(om[1]) >/dev/null
