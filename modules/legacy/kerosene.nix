{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [ aspects.legacy ];
        homeManager = {
          imports = [
            ../../hm/shell
            ../../hm/programs
            ../../hm/programs/graphics.nix
          ];
        };
      };
    };
}
