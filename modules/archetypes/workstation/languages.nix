{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [ aspects.lua ];
      };
    };
}
