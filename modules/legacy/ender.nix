{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      ender = {
        includes = [
          aspects.legacy
        ];
      };
    };
}
