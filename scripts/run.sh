#!/bin/zsh
f=`mktemp /tmp/XXXXXXXrun_archiso`
sed 's/-vga virtio/-device virtio-vga-gl/' `which run_archiso` > $f
sed -i s/\'sdl/\'sdl,gl=on/ $f
[ -n "$UEFI" ] && flags=u
sh $f -${flags}i out/*.iso(om[1]) >/dev/null
