{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [
          aspects.kmonad
        ];

        nixos.dots.kmonad.device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      };
    };
}
