#!/bin/sh

# Tomas Vidal's zsh configuration file
# Features:
#   - vi mode
#   - aliases
#   - custom functions
#   - custom name bar shit
#   - completion TODO (need to complete add arguments yet)
#   - custom keybinds TODO
#   - 'cd' to custom paths from function TODO

HISTFILE=~/.zsh_history

# Load the other files, some options need to be executed before some plugins.
source "$ZDOTDIR/functions"
zsh_add_file "options"
zsh_add_file "plugins"
zsh_add_file "aliases"
zsh_add_file "local_aliases"
zsh_add_file "shortcuts"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
