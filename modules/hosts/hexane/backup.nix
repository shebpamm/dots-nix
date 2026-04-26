{ ... }:
{
  flake.aspects =
    { ... }:
    {
      hexane = {
        nixos =
          { ... }:
          {

            services.btrbk.instances.btrbk.onCalendar = "daily";
            services.btrbk.instances.btrbk.settings = {
              snapshot_preserve = "14d";
              snapshot_preserve_min = "2d";
              volume = {
                "/" = {
                  subvolume = {
                    home = {
                      snapshot_create = "always";
                    };
                  };
                  target = "/snapshots";
                };
              };
            };
          };
      };
    };
}
