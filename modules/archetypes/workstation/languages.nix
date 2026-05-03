{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [
          aspects.lua
          aspects.go
        ];
      };
    };
}
