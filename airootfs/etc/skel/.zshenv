export EDITOR='kamp edit'
export QT_QPA_PLATFORM=wayland
# temporary workarounds to be able to run Wayfire on QEMU
export WLR_RENDERER_ALLOW_SOFTWARE=1
export WLR_NO_HARDWARE_CURSORS=1
export WAYFIRE_CONFIG_FILE=~/.wayfire.conf
# firefox under Wayland by default
export MOZ_ENABLE_WAYLAND=1
export SERENITY_QEMU_DISPLAY_BACKEND=gtk
# for pip modules
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin/"
export FZF_DEFAULT_OPTS='--bind tab:down,shift-tab:up'
