{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      network = {
        includes = [ aspects.dns ];
      };
    };
}
