{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      ender = {
        includes = [
          aspects.raspberry-pi-5
        ];

        nixos = { ... }: { };
      };
    };
}
