if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -e VAULT_TOKEN
set -Ux VAULT_TOKEN (pass 'Vault Token' -sa password)

if test -z (pgrep ssh-agent)
  eval (ssh-agent -c -a ~/.ssh/agent)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

source ~/.config/fish/static_variables.fish

if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1123
    exec startx
  end
end
