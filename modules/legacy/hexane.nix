{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [ aspects.legacy ];
        homeManager = {
          imports = [
            ../../hm/programs
            ../../hm/programs/graphics.nix
            ../../hm/programs/work.nix
            ../../hm/shell
          ];
        };
      };
    };
}
