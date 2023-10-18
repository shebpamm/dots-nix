{ inputs, ... }:
{
  imports = [
    inputs.kmonad.nixosModules.default
  ];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units") {
            if (action.lookup("unit") == "kmonad-integrated.service" || action.lookup("unit") == "kmonad-integrated.path") {
                var verb = action.lookup("verb");
                if (verb == "start" || verb == "stop" || verb == "restart") {
                    return polkit.Result.YES;
                }
            }
        }
    });
  '';

  services.kmonad = {
    enable = true;
    keyboards = {
      integrated = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ../../config/xmonad/miryoku.kbd;
      };
    };
  };
}
