{
  __complete_remote_path = {
    description = "same as __fish_complete_path but specify path to list";
    body = ''
      set PREV_PWD ( pwd )
      cd "$argv[1]"
      __fish_complete_path $argv[2..-1]
      cd "$PREV_PWD"
    '';
  };

  fish_greeting = {
    description = "Greeting displayed at start of shell";
    body = ''
      set_color yellow

      fortune ~/.fortunes

      set_color normal
    '';
  };

  clear = {
    description = "Custom clear implementation";
    body = ''
      for i in (seq 3 (tput lines))
        printf '\n'
      end
      printf '\33[H\33[2J'
    '';
  };

  fish_user_key_bindings = {
    description = "Key bindings";
    body = ''
      bind \cw backward-kill-word
    '';
  };

  xm4 = {
    description = "Connect my Sony XM4 Headphones";
    body = ''
      bluetoothctl power on
      bluetoothctl connect F8:4E:17:2B:3C:83
    '';
  };

  qc45 = {
    description = "Connect my Bose QuietComfort 45 Headphones";
    body = ''
      bluetoothctl power on
      bluetoothctl connect C8:7B:23:4C:04:5B
    '';
  };

  p = {
    description = "Print using bat";
    body = "bat --pager=never $argv";
  };

  gh-user = {
    description = "Get github user from gh api";
    body = "gh api user | jq -r '.login'";
  };

  gh-last-pr = {
    description = "Get last pull request from gh api";
    body = "gh pr list -L 1 --json number --jq '.[0].number'";
  };

  afk-notify = {
    description = "check if used is afk and if so, send notification to phone";
    body = ''
      if test (xprintidle) -ge (math -s 0 $__done_min_cmd_duration/2)
        phone notify $argv
      end
    '';
  };

  kubectl-gd-toggle = {
    description = "use commandline to toggle between the keywords 'get' and 'describe'";
    body = ''
      set -l prompt (commandline)
      switch $prompt
      case "kubectl get*"
        commandline -r (string replace get describe "$prompt")
      case "kubectl describe*"
        commandline -r (string replace describe get "$prompt")
      end
    '';
  };

  acp = {
    description = "lazy command to git add, commit & push all at one";
    body = ''
      git add .
      git commit -m "$argv"
      git push
    '';
  };

  "%" = {
    description = "run command fron nix-store package of the same name";
    body = ''
      nix-shell -p $argv[1] --run $argv[1] &
    '';
  };

  base = {
    description = "go to git root directory";
    body = "cd (git rev-parse --show-toplevel)";
  };
}
