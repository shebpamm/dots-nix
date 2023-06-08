''
for secret in hass-server hass-token hass-imaginary openai-api-key jira-api-token
  if test -O /run/secrets/$secret
    set -x (string upper $secret | tr - _ ) (cat /run/secrets/$secret)
  end
end

bind \ew kubectl-gd-toggle

set __done_enabled 1
set __done_min_cmd_duration 60000
set __done_notification_command "afk-notify \$title \$message"

set fish_prompt_pwd_dir_length 0

printf '\033[3 q'
''
