{ ... }:
{
  flake.aspects = { aspects, ... }: {
    workstation = {
      includes = [
        aspects.system-base
        aspects.cross-platform
      ];
    };
  };
}
