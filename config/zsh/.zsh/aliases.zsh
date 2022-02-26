alias vim="nvim"
alias ls="exa"
alias la="exa -a"
alias li="exa --icons"
alias lg="lazygit"
alias btctl="bluetoothctl"
alias grep="grep --color=auto"
alias reboot-windows="sudo nix-shell -p efibootmgr --run 'efibootmgr -n 0000' && reboot"

# replace AUTO_CD
alias ~="cd ~"
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
