Since demolinux runs on RAM, and that it needs plenty of disk space to build,
you might need additional storage. I mount mine to /data:
  mkdir /data
  mount /dev/sda1 /data

Then, tell pacman to store everything there:
  mkdir /data/.pacman
  kak pacman.conf
/RootDir<ret>5Cdf/;i/data/.pacman<esc>:wq<ret>

Initialize the keyring:
  pacman-key --init --config pacman.conf
  pacman-key --populate archlinux --config pacman.conf
  pacman-key --recv-keys <archzfs key>
  pacman-key --lsign-key <archzfs key>

Then build.
If you get an error, try to delete the git config:
  rm /root/.gitconfig

It is recommended to flash in the background or in a
separate tty as the terminal might crash when overwriting
the running system.

