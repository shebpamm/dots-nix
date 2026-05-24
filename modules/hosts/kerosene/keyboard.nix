{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [
          aspects.kmonad
        ];

        nixos.dots.kmonad.device = "/dev/input/by-id/usb-qmkbuilder_KBD75-event-kbd";
      };
    };
}
