{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [
          aspects.node
          aspects.lua
          aspects.go
        ];
      };
    };
}
