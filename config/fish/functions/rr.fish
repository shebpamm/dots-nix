function rr --description 'Add vpn route and then ssh'
  sudo add-vpn-route $argv >/dev/null 2>/dev/null
  ssh $argv
end
