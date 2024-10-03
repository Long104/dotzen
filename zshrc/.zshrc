
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="/usr/local/bin:/usr/bin:$PATH"


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# Add in snippets
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found


# Load completions
autoload -Uz compinit && compinit


zinit cdreplay -q

# Enable Vim key bindings
bindkey -v

# Basic cursor movement
bindkey 'H' beginning-of-line
bindkey 'L' end-of-line

# Delete the character under the cursor
bindkey 'x' delete-char

# Cut the line
bindkey 'd' kill-line

# Paste
bindkey 'p' yank

# Search history backward
bindkey -M viins 'Ctrl-p' history-search-backward

# Search history forward
bindkey -M viins 'Ctrl-n' history-search-forward


# # Keybindings
# # bindkey -e
# bindkey -v
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region
# # bindkey "^P" up-line-or-beginning-search
# # bindkey "^N" down-line-or-beginning-search
# # bindkey "^[a" beginning-of-line
# # bindkey "^[e" end-of-line
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region
# # bindkey "^P" up-line-or-beginning-search
# # bindkey "^N" down-line-or-beginning-search
# bindkey "^[a" beginning-of-line
# bindkey "^[e" end-of-line

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias cd='z'
alias ls="eza --color=always --icons=always" 
alias lt="eza --color=always --icons=always -T " 
# alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions" 
alias nf="clear && neofetch" 
alias apprun="osascript -e 'tell application \"System Events\" to return name of processes whose background only is false'"
alias psrun='ps ux -p $(osascript -e "tell application \"System Events\" to return unix id of processes whose background only is false")'
alias convert='~/dotfiles/script/.config/script/350-image-to-all.sh'
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias git-bare="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias n="nvim"
alias f="nvim -c ':Telescope find_files'"
alias py-activate="source ~/myenv/bin/activate.fish"
alias py-deactivate="deactivate"
alias s="NVIM_APPNAME=Shoshinvim nvim"

# switcher

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
