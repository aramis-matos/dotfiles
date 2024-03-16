set fish_greeting
set -g fish_key_bindings fish_vi_key_bindings
fish_add_path ~/Downloads/nvim-linux64/bin/
if status is-interactive
    # Commands to run in interactive sessions can go here
end






set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/ccyanide/.ghcup/bin # ghcup-env