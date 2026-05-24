{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [ aspects.hidpi ];
        nixos = { ... }: { };
        homeManager = { ... }: { };
      };
    };
}
