{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ 
        aspects.system-base
        aspects.openrgb
      ];

      nixos = { pkgs, ... }: {
        environment.systemPackages = [
          pkgs.blahaj # first package added in dendritic!
        ];
      };
    };
  };
}
