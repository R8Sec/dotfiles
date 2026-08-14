setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=''

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action
bindkey '^p' history-search-backward              # search history up
bindkey '^n' history-search-forward              # search history down

typeset -U path PATH

path=(
    "$HOME/.local/bin"
    /snap/bin
    $path
)

# zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME/.git" ]]; then
    mkdir -p "${ZINIT_HOME:h}"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# PLUGINS
zinit light zsh-users/zsh-completions

zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load zsh-completions
autoload -U compinit && compinit
zinit cdreplay -q

# fzf shell integration
(( $+commands[fzf] )) && source <(fzf --zsh)

(( $+commands[fzf] )) && zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=5000
setopt hist_reduce_blanks
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_find_no_dups
setopt hist_ignore_space      # ignore commands that start with space
setopt share_history          # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# enable color support of ls, less and man, and also add handy aliases
if (( $+commands[dircolors] )); then
    if [[ -r "$HOME/.dircolors" ]]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# Completion styling
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':fzf-tab:complete:*:*' fzf-preview '
    if [[ -d "$realpath" ]]; then
        ls -lah --color=always -- "$realpath"
    elif (( $+commands[batcat] )) && [[ -f "$realpath" ]] && [[ "$(file -- $realpath)" == *text* ]]; then
        batcat --color=always --style=numbers --line-range :500 -- "$realpath"
    fi
'

# zoxide
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd z)"

# Custom aliases
# ls
alias ll='ls -lh'
alias la='ls -Ah'
alias lla='ls -lAh'
alias l='ls'

# ip
alias ipa='ip -br addr'
alias ipl='ip -br link'

# The weather
alias wttr='curl wttr.in'

# other
alias vim='nvim'

# Initialise starship
(( $+commands[starship] )) && eval "$(starship init zsh)"

# Highlighting
zinit light zsh-users/zsh-syntax-highlighting
