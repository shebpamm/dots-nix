{ ... }:
{
  flake.aspects =
    { ... }:
    {
      clipcat = {
        homeManager =
          { ... }:
          {
            services.clipcat = {
              enable = true;
              daemonSettings = {
                log.emit_journald = true;

                watcher = {
                  enable_clipboard = true;
                  enable_primary = false;
                };

                desktop_notification.enable = false;
              };
            };
          };
      };
    };
}
