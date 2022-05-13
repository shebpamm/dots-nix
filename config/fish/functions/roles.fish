function roles --wraps=' ~/efienv/bin/ansible-galaxy install -r requirements.yml -p roles/' --description 'alias roles= ~/efienv/bin/ansible-galaxy install -r requirements.yml -p roles/'
   ~/efienv/bin/ansible-galaxy install -r requirements.yml -p roles/ $argv; 
end
