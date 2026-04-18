{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [
          aspects.systemd-boot
          aspects.workstation
          aspects.openrgb
          aspects.ntfs
          aspects.nas-mount
          aspects.flipperzero
          aspects.nvidia-base
          aspects.ollama
          aspects.virtualbox
        ];

        nixos =
          { pkgs, ... }:
          {
            boot.kernelPackages = pkgs.linuxPackages_6_1; # TODO: update to latest after refactor
          };
      };
    };
}
