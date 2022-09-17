# See https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# some key bindings
set -o vi
bindkey ^R history-incremental-pattern-search-backward
bindkey '^[[Z' reverse-menu-complete

# to be able to show
# help for internal commands
autoload run-help
unalias run-help

# useful aliases
# e.g. cmd >DN to redirect to /dev/null
alias -g DN=/dev/null
alias help=run-help
alias kg=kamp-grep
alias kf=kamp-files
alias gd='git diff'
alias gds='git diff --staged'
alias gap='git add --patch'
alias gc='git commit'
alias kakrc='kak ~/.config/kak/kakrc'
# specific to myself
alias sr='cd /data/programming/SerenityOS'
alias dm='cd /data/programming/demolinux'

aur() {
	git clone https://aur.archlinux.org/$1 ${@:2}
}

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
	done&!
	# stop if return is pressed
	p=$!;
	trap 'kill $p; return 1' INT
	read -st $((t+1)); kill $p
}

# calculate time the last command
# executed took to finish.
preexec() {
	# set terminal title to current command
	1=`sed s/%/%%/g <<< "$1"`
	printf "\033]0;$1\a"

	initial_seconds=$SECONDS
}

precmd() {
	# reset terminal title
	printf "\033]0;\a"

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
RPROMPT='%B%F{red}%(?..%?)'
# beautiful prompt
PROMPT='%B%(!.%F{red}.%F{green})%n%b%F{white} on %B%m%b'$'\n''%# %b'

# completion
autoload -Uz compinit && compinit

source \
/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

