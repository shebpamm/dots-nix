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
}
