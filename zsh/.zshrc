zle_highlight=('paste:none')
autoload -U colors && colors

source $ZDOTDIR/zsh_functions

zsh_add_plugin zsh-users/zsh-syntax-highlighting 0.7.1
zsh_add_file zsh_comp
zsh_add_file zsh_history
zsh_add_file zsh_prompt
zsh_add_file zsh_alias
zsh_add_dir $XDG_CONFIG_HOME/shell-env

eval "$(direnv hook zsh)"
eval "$(dircolors $ZDOTDIR/dir_colors)"
