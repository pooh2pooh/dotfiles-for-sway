#zmodload zsh/zprof
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pooh/.zshrc'

autoload -Uz compinit
#compinit
# End of lines added by compinstall
#

eval "$(starship init zsh)"
setopt HIST_IGNORE_ALL_DUPS


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#source /usr/share/fzf-tab-completion/zsh/fzf-zsh-completion.sh


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#606060"
ZSH_AUTOSUGGEST_STRATEGY="history"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=#ffffff,bg=#85bb65,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=#ffffff,bg=#ff0000,bold"




#
# ALIASES!!!
# 

# basics
alias v="vim"
alias l="lsd -lX"
alias ll='function __ll() { if [ $# -eq 0 ]; then lsd -lah --color=always | awk '"'"'{$2=""; $3=""; $4=""; $5=""; print}'"'"'; else lsd -lah --color=always "$@" | awk '"'"'{$2=""; $3=""; $4=""; $5=""; print}'"'"'; fi; }; __ll'
alias bt="bluetuith"
alias myip="curl -s ifconfig.so | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'"

# VPN
alias ru_on="wg-quick up wg0-client && notify-send -u critical 'VPN on (RUSSIA)' 'Соединение установлено'"
alias ru_off="wg-quick down wg0-client && notify-send -u critical 'VPN off (RUSSIA)' 'Соединение разорвано'"
alias usa_on="wg-quick up wg1-client && notify-send -u critical 'VPN on (USA)' 'Соединение установлено'"
alias usa_off="wg-quick down wg1-client && notify-send -u critical 'VPN off (USA)' 'Соединение разорвано'"

# ssh and fm
alias far="far2l --tty"
alias s="kitten ssh"
alias neofetch="neofetch --source /home/pooh/.config/neofetch/image.txt"

# other
alias tb="nc termbin.com 9999" # copy output terminak command to ethernet
alias xr="sudo xampp restart"
alias gp="ps aux | grep -i" # find process pid
alias add="git add"
alias commit="git commit -m"
alias push="git push"
alias sv="sudo vim"
alias diff="diff --color"



#
# REBIND KEYS!!!
#

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
#bindkey "^I" fzf_completion
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word




_zlf() {
	emulate -L zsh
	local d=$(mktemp -d) || return 1
	{
		mkfifo -m 600 $d/fifo || return 1
		#tmux split -bf zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" || return 1
		kitty zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" &!
		local fd
		exec {fd}<$d/fifo
		zle -Fw $fd _zlf_handler
	} always {
	rm -rf $d
}
}
zle -N _zlf
bindkey '^A' _zlf

_zlf_handler() {
	emulate -L zsh
	local line
	if ! read -r line <&$1; then
		zle -F $1
		exec {1}<&-
		return 1
	fi
	eval $line
	zle -R
}
zle -N _zlf_handler
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
#zprof # bottom of .zshrc
#source /usr/share/nvm/init-nvm.sh

source /home/pooh/.config/broot/launcher/bash/br

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/pooh/.dart-cli-completion/zsh-config.zsh ]] && . /home/pooh/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

