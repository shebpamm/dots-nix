{ ... }:
{
  flake.aspects =
    { ... }:
    {
      system-base = {
        nixos =
          { ... }:
          {
            hardware.enableRedistributableFirmware = true;
            hardware.enableAllFirmware = true;
          };
        homeManager = { ... }: { };
      };
    };
}
