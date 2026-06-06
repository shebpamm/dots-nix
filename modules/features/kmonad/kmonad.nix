{ ... }:
{
  flake.aspects =
    { ... }:
    {
      kmonad = {
        nixos =
          { config, lib, ... }:
          {
            options.dots.kmonad = {
              device = lib.mkOption {
                type = lib.types.str;
                description = "Input device to use for kmonad";
              };
            };

            config = {
              security.polkit.extraConfig = ''
                polkit.addRule(function(action, subject) {
                    if (action.id == "org.freedesktop.systemd1.manage-units") {
                        if (action.lookup("unit") == "kmonad-default.service" || action.lookup("unit") == "kmonad-default.path") {
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
                  default = {
                    device = config.dots.kmonad.device;

                    defcfg = {
                      enable = true;
                      fallthrough = true;
                    };

                    config = builtins.readFile ./layouts/homerow.kbd;
                  };
                };
              };
            };
          };
        homeManager = { ... }: { };
      };
    };
}
