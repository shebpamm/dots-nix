{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ 
        aspects.workstation
        aspects.openrgb
        aspects.ntfs
      ];

      nixos = { pkgs, ... }: {
        environment.systemPackages = [
          pkgs.blahaj # first package added in dendritic!
        ];
      };
    };
  };
}
