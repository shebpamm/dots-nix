{ ... }:
{
  flake.aspects =
    { ... }:
    {
      steam = {
        nixos =
          { ... }:
          {
            programs.steam = {
              enable = true;
              remotePlay.openFirewall = true;
            };
          };
        homeManager = { ... }: { };
      };
    };
}
