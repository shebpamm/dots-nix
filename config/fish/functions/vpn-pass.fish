function vpn-pass
  set USER (pass 'Eficode Intra' -sa username)
  set PASSWORD (pass 'Eficode Intra' -sa password)

  read -P "Auth token> " TOKEN

  echo "$USER
$PASSWORD$TOKEN"
end
