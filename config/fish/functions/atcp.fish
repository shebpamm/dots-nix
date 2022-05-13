function atcp --description 'Copy file from ansible root template'
  cp -r ~/eficode/devel/Eficode\ Root\ Templates/ansible_template/$argv $PWD/$argv
end
