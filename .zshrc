# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pooh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

eval "$(starship init zsh)"
setopt HIST_IGNORE_ALL_DUPS


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#source /usr/share/fzf-tab-completion/zsh/fzf-zsh-completion.sh


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#c71585,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY="history"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=#ffffff,bg=#85bb65,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=#ffffff,bg=#ff0000,bold"


alias v="nvim"
alias l="lsd -lX"
alias ll="lsd -lah"
alias bt="bluetuith"
alias vpnon="wg-quick up wg0-client"
alias vpnoff="wg-quick down wg0-client"

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
