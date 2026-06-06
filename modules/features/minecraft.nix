{ ... }:
{
  flake.aspects =
    { ... }:
    {
      minecraft = {
        homeManager =
          { ... }:
          {
            programs.prismlauncher.enable = true;
          };
      };
    };
}
