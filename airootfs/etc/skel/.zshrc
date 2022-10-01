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
alias gs='git status'
alias gc='git commit'
alias gpl='git pull'
alias gps='git push'
alias gl='git log'
alias grc='git rebase --continue'
# easily jump to common configuration files
alias kakrc='kak ~/.config/kak/kakrc'
alias wfrc='kak ~/.wayfire.conf'
alias tmuxrc='kak ~/.tmux.conf'
alias zshrc='kak ~/.zshrc'
# specific to myself
alias sr='cd /data/programming/SerenityOS'
alias dm='cd /data/programming/demolinux'

aur() {
	git clone https://aur.archlinux.org/$1 ${@:2}
}

info() {
	echo -e "\x1b[1m[*] \x1b[32m$@\x1b[0m" 1>&2
}

infon() {
	echo -ne "\x1b[1m[*] \x1b[32m$@\x1b[0m" 1>&2
}

infot() {
	# this should really be implemented as a separate
	# command, not written in zsh

	t=$(grep -o '%[0-9]\+s' <<< $@)
	t=${${t%?}:1}
	nl=$(wc -l <<< $@)
	nl=$(($nl+1))

	repeat $nl echo 1>&2
	for i in {0..$t}; do
		echo -ne "\x1b[${nl}A\x1b[0K" 1>&2
		# <space>s are replaced in the second
		# sed, because putting spaces instead of
		# them in the first sed leads to weird
		# errors (most likely a bug)
		echo -e "\x1b[1m[*] \x1b[32m$(sed 's#%\([0-9]\+\)s#'$((($t==0))&&echo now||echo 'in\x1b[0m<space>'$t'<space>\x1b[1;32msecond'$((($t>1))&&echo s))'#' <<< $@ | sed 's/<space>/ /g')\x1b[0m" 1>&2
		t=$(($t-1))
		sleep 1
	done&!
	p=$!;

	trap 'kill $p 2>DN; return 1' INT

	# stop if any key is pressed
	# yes, this is awful. i've tried many techniques,
	# including read -kt (which only works from time to time),
	# killing a subprocess containing read in the above for loop
	# once it ends, none of which succeeded, due to some quirks
	# or bugs in zsh. read being a shell builtin being the main
	# cause: that's an horrible design for a shell where the
	# concept is to have commands working altogether. let's
	# say you want to stop reading user input after some time:
	# the shell has to implement a command which supports -t
	# (which isn't POSIX). in case it's buggy (the case of
	# zsh, try to use read -kt while having a background job
	# printing to the standard output and it will act weird),
	# you're on your own...
	# what if instead you want to stop it when some condition
	# is met? well, same fate mate. and you can't use the
	# timeout command, since read is a builtin. oh and you
	# can't use kill either, because read doesn't spawn a
	# process. it's a builtin, remember?
	timeout $((t+1)) perl -e '
	`stty cbreak -echo`;sysread STDIN,$,,1;print$,
	' && kill $p 2>DN
	return 0
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

[ `tty` != /dev/tty1 -a -z "$TMUX" ] && exec tmux
