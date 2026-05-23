{ ... }:
{
  flake.aspects =
    { ... }:
    {
      firefox = {
        homeManager =
          { ... }:
          {
            programs.firefox.enable = true;
          };
      };
    };
}
