{ ... }:
{
  flake.aspects =
    { ... }:
    {
      steam = {
        nixos =
          { pkgs, ... }:
          {
            programs.steam = {
              enable = true;
              remotePlay.openFirewall = true;
            };
          };
        homeManager = { pkgs, ... }: { };
      };
    };
}
