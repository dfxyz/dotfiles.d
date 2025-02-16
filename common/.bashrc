[[ $- != *i* ]] && return # ignore if not interactive shell

HISTSIZE=1000

[[ -n $SSH_CONNECTION ]] && { remoteMarker=*; remoteTitle=' (remote)'; }
[[ $EUID -ne 0 ]] && promptMarker=$ || promptMarker=#
PS1=$'\e]0;bash: $PWD$remoteTitle\a'
PS1=$PS1$'\e[32m\u@\h\e[0m$remoteMarker \e[33m\w\e[0m'
if [[ -z "$WINELOADERNOEXEC" ]] ; then
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    if [[ -f "$COMPLETION_PATH/git-prompt.sh" ]]; then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        PS1=$PS1$'\e[36m`__git_ps1`\e[0m'
    fi
fi
PS1=$PS1$'\n$promptMarker '

[[ -f ~/.commonrc ]] && source ~/.commonrc
