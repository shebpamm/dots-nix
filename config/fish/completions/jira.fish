function __fish_complete_own_jira_tickets
  jira list --query 'project = DEVOPS AND status in ("In Progress", Review, "To Do") AND assignee in (currentUser()) order by created DESC' --template complete
end

function __jira_perform_completion
  # echo "Performing completion"

  set -l commands 0
  for subcommand in (jira --help)
    # echo "Checking $subcommand"
    if test "$subcommand" = "Commands:"
      set commands 1
    else if test "$commands" -eq 1
      # echo "Found command $subcommand"
      set -l parts (string split -m 1 ":" $subcommand)
      set -l subcommand (string trim $parts[1])
      set -l help (string trim $parts[2])

      if not contains "$subcommand" help version
        complete --command jira --exclusive --arguments $subcommand --condition __fish_use_subcommand --description "$help"
      end
    end
  end
end

function __jira_perform_ticket_completion
  set -l commands view done slack

  complete -x -c jira -n "__fish_seen_subcommand_from $commands" -a '(__fish_complete_own_jira_tickets)' -d "ASD"
end

function __jira_prepare_completions
  __jira_perform_completion
  __jira_perform_ticket_completion
end

# Remove any pre-existing completions for the program since we will be handling all of them.
complete -c jira -e

# The call to __jira_prepare_completions will setup __jira_comp_results
# which provides the program's completion choices.
__jira_prepare_completions
