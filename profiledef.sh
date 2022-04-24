#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="demostanis"
iso_label="DEMOSTANIS_$(date +%Y%m)"
iso_publisher="demostanis Inc."
iso_application="demostanis Linux"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="erofs"
airootfs_image_tool_options=('-d3zlz4hc,12')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/usr/bin/torbrowser"]="0:0:755"
  ["/usr/bin/lofi"]="0:0:755"
  ["/usr/bin/chillhop"]="0:0:755"
  ["/usr/bin/song"]="0:0:755"
  ["/usr/bin/themed-bemenu"]="0:0:755"
  ["/usr/bin/theme"]="0:0:755"
  ["/usr/bin/effects"]="0:0:755"
  ["/usr/bin/color-picker"]="0:0:755"
  ["/usr/bin/fetch"]="0:0:755"
  ["/usr/bin/wific"]="0:0:755"
)
