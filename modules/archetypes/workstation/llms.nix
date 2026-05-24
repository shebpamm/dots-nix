{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [
          aspects.claude
          aspects.cursor
        ];
      };
    };
}
