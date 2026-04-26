{ ... }:
{
  flake.aspects =
    { ... }:
    {
      kerosene = {
        nixos.system.stateVersion = "23.11";
        homeManager.home.stateVersion = "23.11";
      };
    };
}
