{ ... }:
{
  flake.aspects =
    { ... }:
    {
      cursor = {
        homeManager =
          { ... }:
          {
            programs.cursor.enable = true;
          };
      };
    };
}
