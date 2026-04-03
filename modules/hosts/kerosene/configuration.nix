{ inputs, ... }:
{
  flake.modules.nixos.kerosene =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.blahaj # first package added in dendritic!
      ];
    };
}
