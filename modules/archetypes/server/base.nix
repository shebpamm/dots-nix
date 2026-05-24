{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      server = {
        includes = [
          aspects.system-base
          aspects.esxi
        ];
      };
    };
}
