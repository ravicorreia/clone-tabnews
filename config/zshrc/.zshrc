# silent the direnv output
export DIRENV_LOG_FORMAT=""

if [ -e /home/ravicorreia/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ravicorreia/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

  # powerlevel10k
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

  # Editor
EDITOR='nvim'

    # Zinit
  # Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  # Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
  # Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"
  # Load Completions
autoload -U compinit && compinit
  # Completion Styling
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -a $realpath'
  # Add in Aloxaf fzf-tab plugin
zinit ice depth=1; zinit light Aloxaf/fzf-tab
  # Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
  # Add in oh-my-zsh plugins
zinit snippet OMZP::git
  # Add in zsh plugins
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
  # Zinit pede pra colocar isso pra ajeitar ordem de carregamento dos plugins \_('-')_/
zinit cdreplay -q

  # powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
# [[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh

  # History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

  # Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"

    # Keybindigns
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
  # Enable vi mode
bindkey -v
  # Set jj as escape
bindkey -M viins 'jj' vi-cmd-mode

alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias nv='nvim'
alias cl='clear'
alias lg='lazygit'
alias q='exit'
alias nix-shell='nix-shell --command "exec zsh"'
alias nix-shell='nix-shell --command "exec zsh"'
alias dot-update='home-manager switch --flake ~/dotfiles/#ravicorreia --impure'
alias home-flake-up='echo "Atualizando o flake do Home Manager" && nix flake update ~/dotfiles'

alias l='ls -a'
alias ~='cd ~'
