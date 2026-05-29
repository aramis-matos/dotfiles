set -U fish_greeting
fish_vi_key_bindings
fish_add_path -g ~/bin
alias vi="nvim"
alias vim="nvim"

set -g GTK_IM_MODULE "fcitx"
set -g QT_IM_MODULE "fcitx"
set -g XMODIFIERS "@im=fcitx"



# Must be last
oh-my-posh init fish --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/uew.omp.json" | source
