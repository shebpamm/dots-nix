{ inputs, ... }:
{
  flake.aspects.kerosene.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.blahaj # first package added in dendritic!
      ];
    };
}
