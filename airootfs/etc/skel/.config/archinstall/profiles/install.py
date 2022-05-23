from getpass import getpass
import archinstall
import os.path
import os

print('''Welcome to the demolinux installer!
It is currently in its very infancy. While it works,
it has a very poor error handling and might fail in random cases unexpectedly.
You should try to run `wipefs` on the drive you want to install to.
This process will ask you some questions, and install everything for you.
Note that this will erase your entire drive.

Press enter to continue.''')
input()

print('Available disks: ')
disks = archinstall.all_blockdevices(partitions=False)
for i, (path, disk) in enumerate(disks.items()):
    if not (path.endswith('loop0') or path.endswith('sr0')):
        print(f'{i}. {disk}')

def choose_disk():
    try:
        choice = input('Your choice: ')
        disk = list(disks.values())[int(choice)]
        disk.keep_partitions = False
    except (IndexError, ValueError):
        print('Invalid choice.')
        choose_disk()

choose_disk()

print(f'Selected {disk}')

method = archinstall.MBR

if archinstall.has_uefi():
    print('Detected UEFI')
    method = archinstall.GPT

layout = {
    disk.path: {
        'wipe': True,
        'partitions': [{
            'type': 'primary',
            'start': '3MiB',
            'size': '203MiB',
            'boot': True,
            'encrypted': False,
            'wipe': True,
            'mountpoint': '/boot',
            'filesystem': {'format': 'fat32'},
        },
        {
            'type': 'primary',
            'start': '206MiB',
            'encrypted': True,
            'wipe': True,
            'mountpoint': '/',
            'filesystem': {'format': 'ext4'},
            'size': '100%',
        }],
    }
}

with archinstall.Filesystem(disk, method) as fs:
    fs.load_layout(layout[disk.path])

with archinstall.Installer('/mnt') as installation:
    installation.mount_ordered_layout(layout)

    if installation.minimal_installation():
        installation.set_hostname('demolinux')
        installation.add_bootloader('grub-install' if not archinstall.has_uefi() else 'systemd-bootctl')

        print('Installing packages...')
        installation.add_additional_packages(open('/usr/src/demolinux/packages.x86_64').read().splitlines())

        print('Copying files...')
        archinstall.SysCommand(f'rsync -Eav -- /usr/src/demolinux/airootfs/* "{installation.target}"')

