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
      set_color $fish_color_autosuggestion

      fortune -s

      set_color normal
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

  afk-notify = {
    description = "check if used is afk and if so, send notification to phone";
    body = ''
      if test (xprintidle) -ge (math -s 0 $__done_min_cmd_duration/2)
        phone notify $argv
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
}
