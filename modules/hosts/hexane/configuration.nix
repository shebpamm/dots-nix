{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [
          aspects.grub
          aspects.workstation
          aspects.laptop-base
          aspects.polkit
          aspects.autorandr
          aspects.wsone
          aspects.work
        ];
      };
    };
}
