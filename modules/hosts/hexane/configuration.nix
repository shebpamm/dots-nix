{ ... }:
{
  flake.aspects = { aspects, ... }: {
    hexane = {
      includes = [
        aspects.grub
        aspects.workstation
      ];
    };
  };
}
