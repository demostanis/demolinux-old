#!/bin/zsh
[ -z $DEVICE ] && {
	echo missing \$DEVICE
	exit 1
}
if=( out/*.iso(om[1]) )
dd if=$if of=$DEVICE bs=1M status=progress
