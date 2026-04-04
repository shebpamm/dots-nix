{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ aspects.system-base ];

      nixos = { pkgs, ... }: {
        environment.systemPackages = [
          pkgs.blahaj # first package added in dendritic!
        ];
      };
    };
  };
}
