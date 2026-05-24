{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      bat = {
        includes = [ aspects.catppuccin ];
        homeManager =
          { ... }:
          {
            catppuccin.bat.enable = true;

            programs.bat.enable = true;
            programs.bat.config = {
              style = "numbers";
              paging = "never";
            };
          };
      };
    };
}
