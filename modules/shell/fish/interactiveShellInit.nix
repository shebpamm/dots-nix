''
for secret in hass-server hass-token hass-imaginary
  if test -O /run/secrets/$secret
    set -x (string upper $secret | tr - _ ) (cat /run/secrets/$secret)
  end
end
''
