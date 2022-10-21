#!/usr/bin/env bash

exec()
{
  rofi -show fb -modes "fb:$0" --normal-window
}

if [ "$1" = "run" ]; then
  exec
  exit
fi

export VAULT_FORMAT="json"
export VAULT_TOKEN

if [ -z "$VAULT_TOKEN" ]; then
  VAULT_TOKEN=$(toket token read)
fi

if [ -z "$1" ]; then
  curl -H "X-Vault-Token: $VAULT_TOKEN" https://vault.root.eficode.io/v1/sys/internal/ui/mounts | jq '.data.secret | keys | sort | .[]' -r
else
  # Does input end with slash?
  if [ "${1: -1}" = "/" ]; then
    vault kv list "$1" | jq -r ".[] | . = \"$1\" + ."
  # Does it start with >?
  elif [[ "$1" = *": "* ]]; then 
    IFS=': ' read -r path key <<< "$1"
    res=$(vault kv get "$path" | jq -r --arg key "$key" '.data.data[$key]')
    echo "$res" | xclip -sel clip >/dev/null 2>&1

  else
    vault kv get "$1" | jq -r --arg path "$1" '.data.data | keys[] | . = $path + ": " + .'
  fi
fi
