{ ... }:
{
  flake.aspects =
    { ... }:
    {
      trackpad = {
        nixos =
          { ... }:
          {
            services.libinput.touchpad.naturalScrolling = true;
          };
        homeManager = { ... }: { };
      };
    };
}
