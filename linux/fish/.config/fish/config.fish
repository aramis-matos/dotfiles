set -U fish_greeting
fish_vi_key_bindings
set -g fish_add_path $HOME/bin
alias vi="nvim"
alias vim="nvim"


# Must be last
oh-my-posh init fish --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/uew.omp.json" | source
