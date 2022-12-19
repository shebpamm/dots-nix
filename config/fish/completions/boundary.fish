
function __complete_boundary
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /nix/store/lwf1vi3rcalfy3jpkic648daijmqjdkx-boundary-0.10.1/bin/boundary
end
complete -f -c boundary -a "(__complete_boundary)"

