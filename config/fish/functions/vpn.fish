function vpn --wraps='sudo openvpn --config ~/eficode/vpn/efivpn.ovpn --auth-user-pass ~/eficode/vpn/pass.conf' --wraps='sudo openvpn --config eficode/vpn/efivpn.ovpn --auth-user-pass (vpn-pass | psub)' --wraps='sudo openvpn --config ~/eficode/vpn/efivpn.ovpn --auth-user-pass (vpn-pass | psub)' --description 'alias vpn sudo openvpn --config ~/eficode/vpn/efivpn.ovpn --auth-user-pass (vpn-pass | psub)'
  sudo openvpn --config ~/eficode/vpn/efivpn.ovpn --auth-user-pass (vpn-pass | psub) $argv; 
end
