{ ... }:
{
  flake.aspects =
    { ... }:
    {
      bluetooth = {
        nixos =
          { pkgs, ... }:
          {
            hardware.bluetooth.enable = true;
            services.blueman.enable = true;
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
