#!/bin/sh
sed -i 's#<packages>#'"$(pwd)"/packages'#' pacman.conf
# unmount all stuff inside work/
IFS=$'\n'; for m in "$(findmnt -ao TARGET | cut -d- -f2- | grep $PWD)"; do
umount -l "$m" 2>/dev/null
done
rm -rf work && mkarchiso -v -w work -o out .
# for ease of understandability
sed -i 's#'"$(pwd)"/packages'#<packages>#' pacman.conf
chown -R 1000:1000 out
