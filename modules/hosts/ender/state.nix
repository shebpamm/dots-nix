{ ... }:
{
  flake.aspects =
    { ... }:
    {
      ender = {
        nixos.system.stateVersion = "25.11";
      };
    };
}
