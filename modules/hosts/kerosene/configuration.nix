{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ 
        aspects.system-base
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
