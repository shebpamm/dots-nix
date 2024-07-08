complete -c ansible-playbook -s l -l limit --no-files -ra "(ansible-inventory --graph -i inventories/production/hosts 2>/dev/null | grep -P '[^-|\s].*\.smartly\.io' -o | sort | uniq)"
