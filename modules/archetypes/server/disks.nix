{ ... }:
{
  flake.aspects =
    { ... }:
    {
      server = {
        nixos =
          { ... }:
          {
            # Grub is already set by the virtualbox module, but if we want to nixos-rebuild we need to have it as well
            boot.loader.grub.device = "/dev/sda";

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
