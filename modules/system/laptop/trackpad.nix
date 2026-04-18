{ ... }:
{
  flake.aspects =
    { ... }:
    {
      trackpad = {
        nixos =
          { pkgs, ... }:
          {
            services.libinput.touchpad.naturalScrolling = true;
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
