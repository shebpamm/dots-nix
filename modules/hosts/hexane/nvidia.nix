{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [ aspects.nvidia-prime ];
        nixos =
          { ... }:
          {
            hardware.nvidia.prime = {
              intelBusId = "PCI:0:2:0";
              nvidiaBusId = "PCI:1:0:0";
            };
          };
      };
    };
}
