If you want to simply try demolinux, I publish some (highly compressed) ISOs in the GitHub releases.

Building demolinux yourself might be hard, since weird issues sometimes appear.
If you're not running Arch Linux or one of its derivatives, you need to find a way to install
pacman, archiso and arch-install-scripts (with pacstrap). Some distros package them. Otherwise,
you need to build them yourself from source.

If you are running Arch Linux, you only need to `pacman -S archiso git`. Clone the repository
and run `make` as root. That should build packages and the ISO. Depending on your hardware, this
might take awhile. For more information about make targets, check [`MAKE.md`](./docs/MAKE.md).

If you are already running demolinux, check [`BUILDING_ON_DEMOLINUX.md`](./docs/BUILDING_ON_DEMOLINUX.md).

Once built, you can flash the ISO using the `flash` make target.

It is recommended to modify demolinux to your taste. Many places hardcode `/data`, since that's where
I store permanent files, but that directory is never created by default (you should create it, on a separate partition).
My git credentials are also in `/etc/gitconfig`, you should replace them unless you are me (if you are, please kill yourself).

Finally, if you modified demolinux enough that you like it, chances are I don't merge your changes (unless that's some
super cool thing I never thought about that improves my life. If it's just adding chromium to the packages.x86_64 file,
I won't be interested). You should instead fork it, `fd -tf -x sed -i s/demolinux/myverycoolname/gi`, and publish the source somewhere.

