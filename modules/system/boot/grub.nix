{ ... }:
{
  flake.aspects =
    { ... }:
    {
      grub = {
        nixos =
          { ... }:
          {
            boot.loader = {
              efi.canTouchEfiVariables = true;
              grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                enableCryptodisk = true;
                configurationLimit = 3;
              };
            };
          };
        homeManager = { ... }: { };
      };
    };
}
