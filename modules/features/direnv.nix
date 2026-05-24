{ ... }:
{
  flake.aspects =
    { ... }:
    {
      direnv = {
        homeManager =
          { ... }:
          {
            programs.direnv = {
              enable = true;
              silent = true;
            };
          };
      };
    };
}
