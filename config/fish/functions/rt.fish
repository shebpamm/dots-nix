function rt --wraps='sudo add-vpn-route' --description 'alias rt=sudo add-vpn-route'
  sudo add-vpn-route $argv; 
end
