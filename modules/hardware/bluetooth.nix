{ ... }:
{
  flake.aspects =
    { ... }:
    {
      bluetooth = {
        nixos =
          { ... }:
          {
            hardware.bluetooth.enable = true;
            services.blueman.enable = true;
          };
        homeManager = { ... }: { };
      };
    };
}
