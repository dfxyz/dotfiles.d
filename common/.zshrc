setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

autoload compinit
if [[ $OS == "Windows_NT" ]]; then
    DRIVES=$(mount | sed -n 's|^[A-Z]: on /\([a-z]\).*|\1|p')
    zstyle ':completion:*' fake-files /: "/:$DRIVES"
    unset DRIVES
fi
compinit

autoload vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats $'\e[36m(%b)\e[0m'
[[ -n $SSH_CONNECTION ]] && { remoteMarker=*; remoteTitle=' (remote)'; }
PS1=$'\e]0;zsh: %~$remoteTitle\a'
PS1=$PS1$'\e[32m%n@%m\e[0m$remoteMarker \e[33m%~\e[0m ${vcs_info_msg_0_}\n'
PS1=$PS1'%(!.#.$) '
precmd() { vcs_info }

bindkey "^[[H" beginning-of-line # Home
bindkey "^[[1~" beginning-of-line # Home
bindkey "^[[F" end-of-line # End
bindkey "^[[4~" end-of-line # End
bindkey "^[[5~" beginning-of-history # PageUp
bindkey "^[[6~" end-of-history # PageDown
bindkey "^[[2~" overwrite-mode # Insert
bindkey "^[[3~" delete-char # Delete
bindkey "^[[3;5~" kill-word # Ctrl+Delete
bindkey "^[[1;5D" backward-word # Ctrl+Left
bindkey "^[[1;5C" forward-word # Ctrl+Right

[[ -f ~/.commonrc ]] && source ~/.commonrc
