{ ... }:
{
  flake.aspects =
    { ... }:
    {
      spotify = {
        nixos =
          { ... }:
          {
            services.spotifyd.enable = true;
          };
        homeManager = { ... }: { };
      };
    };
}
