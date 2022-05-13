function __complete_remote_path --description 'same as __fish_complete_path but specify path to list'
  set PREV_PWD ( pwd )
  cd "$argv[1]"
  __fish_complete_path $argv[2..-1]
  cd "$PREV_PWD"
end
