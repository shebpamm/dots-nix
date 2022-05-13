function pass --wraps='secret-tool lookup account cli | keepassxc-cli show ~/.shush/Passwords.kdbx' --wraps='secret-tool lookup account cli | keepassxc-cli show -q ~/.shush/Passwords.kdbx' --description 'alias pass=secret-tool lookup account cli | keepassxc-cli show -q ~/.shush/Passwords.kdbx'
  secret-tool lookup account cli | keepassxc-cli show -q ~/.shush/Passwords.kdbx $argv; 
end
