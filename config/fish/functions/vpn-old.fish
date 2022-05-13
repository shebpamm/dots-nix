function vpn-old --wraps='sudo openvpn --config ~/eficode/vpn/old.conf --auth-user-pass ~/eficode/vpn/pass.conf' --description 'alias vpn-old=sudo openvpn --config ~/eficode/vpn/old.conf --auth-user-pass ~/eficode/vpn/pass.conf'
  sudo openvpn --config ~/eficode/vpn/old.conf --auth-user-pass ~/eficode/vpn/pass.conf $argv; 
end
