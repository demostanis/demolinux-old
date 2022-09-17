#!/bin/zsh
f=`mktemp /tmp/XXXXXXXrun_archiso`
trap "rm $f" EXIT
sed 's/-vga virtio/-device virtio-vga-gl -display gtk,gl=on/' `which run_archiso` > $f
sed -i s/\'sdl/\'sdl,gl=on/ $f
[ -n "$UEFI" ] && flags=u
[ -n "$DISK" ] && sed -i '/-enable-kvm/{a -drive file='"$DISK"'\\
}' $f
sed -i 's/-m .*/-m 4G\\/' $f
sh $f -${flags}i out/*.iso(om[1]) >/dev/null
