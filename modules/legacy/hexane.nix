{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [ aspects.legacy ];
        homeManager = {
          imports = [
            ../../hm/programs/work.nix
            ../../hm/shell
          ];
        };
      };
    };
}
