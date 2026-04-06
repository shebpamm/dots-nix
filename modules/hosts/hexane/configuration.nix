{ ... }:
{
  flake.aspects = { aspects, ... }: {
    hexane = {
      includes = [
        aspects.workstation
      ];
    };
  };
}
