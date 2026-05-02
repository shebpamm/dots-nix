{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      ender = {
        includes = [
          aspects.raspberry-pi-5
          aspects.system-base
          aspects.ssh
          aspects.fish
        ];
      };
    };
}
