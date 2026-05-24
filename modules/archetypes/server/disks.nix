{ ... }:
{
  flake.aspects =
    { ... }:
    {
      server = {
        nixos =
          { ... }:
          {
            virtualisation.diskSize = 32 * 1024;
            fileSystems."/" = {
              device = "/dev/disk/by-label/nixos";
              fsType = "ext4";
              autoResize = true;
            };
          };
      };
    };
}
