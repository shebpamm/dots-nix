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

  xm4 = {
    description = "Connect my Sony XM4 Headphones";
    body = ''
      bluetoothctl power on
      bluetoothctl connect F8:4E:17:2B:3C:83
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
}
