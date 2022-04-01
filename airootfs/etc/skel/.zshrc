# See https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# some key bindings
bindkey ^R history-incremental-pattern-search-backward

# useful aliases
# e.g. cmd >DN to redirect to /dev/null
alias -g DN=/dev/null

info() {
	echo -e "\x1b[1m[*] \x1b[32m$@\x1b[0m"
}

infon() {
	echo -ne "\x1b[1m[*] \x1b[32m$@\x1b[0m"
}

infot() {
	t=$(grep -o '%[0-9]\+s' <<< $@)
	t=${${t%?}:1}
	nl=$(wc -l <<< $@)
	nl=$(($nl+1))

	repeat $nl echo
	for i in {0..$t}; do
		echo -ne "\x1b[${nl}A\x1b[0K"
		# <space>s are replaced in the second
		# sed, because putting spaces instead of
		# them in the first sed leads to weird
		# errors (most likely a bug)
		echo -e "\x1b[1m[*] \x1b[32m$(sed 's#%\([0-9]\+\)s#'$((($t==0))&&echo now||echo 'in\x1b[0m<space>'$t'<space>\x1b[1;32msecond'$((($t>1))&&echo s))'#' <<< $@ | sed 's/<space>/ /g')\x1b[0m"
		t=$(($t-1))
		sleep 1
	done
}

# calculate time the last command
# executed took to finish.
preexec() {
	initial_seconds=$SECONDS
}

precmd() {
	if [ -n "$initial_seconds" ]; then
		elapsed=$(($SECONDS - $initial_seconds))
		if (( $elapsed > 0 )); then
			format_elapsed=', command took %B'$elapsed's'
		else
			format_elapsed=
		fi
	fi
	export PROMPT='%B%(!.%F{red}.%F{green})%n%b%F{white} on %B%m%b'$format_elapsed$'\n''%# %b'
	unset format_elapsed initial_seconds
}

# show exit code
RPROMPT='%B%F{red}%1(?.%?.)'
# beautiful prompt
PROMPT='%B%(!.%F{red}.%F{green})%n%b%F{white} on %B%m%b'$'\n''%# %b'

# completion
autoload -Uz compinit && compinit

source \
/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# for pip modules
PATH="$PATH:$HOME/.local/bin"

if [ -n "$DISPLAY" ]; then
	# whether we are using software rendering
	glxinfo | grep '\(llvm\|soft\)pipe' >/dev/null 2>&1; qemu=$?
	# ensure we have a recent GLSL version, glitches occur otherwise
	glxinfo | grep GLSL | grep -v '1\.' >/dev/null 2>&1; glsl=$?

	if (($qemu > 0 && $glsl == 0)); then
		grep 'blur \\' $HOME/.wayfire.conf >/dev/null 2>&1
		if (($? > 0)); then # not done already
			sed -i 's/autostart \\/autostart \\\
		blur \\/' $HOME/.wayfire.conf
		cat >>$HOME/.wayfire.conf<<EOF
[animate]
close_animation = fire
EOF
			# Ain't that so fucking ugly
			dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-transparency-percent 50
		fi
	fi
fi

