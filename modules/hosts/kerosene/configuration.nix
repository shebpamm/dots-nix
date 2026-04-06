{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ 
        aspects.workstation
        aspects.openrgb
        aspects.ntfs
        aspects.nas-mount
      ];

      nixos = { pkgs, ... }: {
        environment.systemPackages = [
          pkgs.blahaj # first package added in dendritic!
        ];
      };
    };
  };
}
