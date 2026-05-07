{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [
          aspects.grub
          aspects.workstation
          aspects.laptop-base
          aspects.polkit
          aspects.autorandr
          aspects.wsone
          aspects.claude
        ];

        nixos =
          { pkgs, ... }:
          {
            boot.kernelPackages = pkgs.linuxPackages_6_1; # TODO: update to latest after refactor
          };
      };
    };
}
