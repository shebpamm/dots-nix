{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ 
        aspects.workstation
        aspects.openrgb
        aspects.ntfs
        aspects.nas-mount
        aspects.flipperzero
      ];

      nixos = { pkgs, ... }: {
        boot.kernelPackages = pkgs.linuxPackages_6_1; # TODO: update to latest after refactor

        environment.systemPackages = [
          pkgs.blahaj # first package added in dendritic!
        ];
      };
    };
  };
}
