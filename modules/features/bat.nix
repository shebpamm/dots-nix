{ ... }:
{
  flake.aspects =
    { ... }:
    {
      bat = {
        homeManager =
          { ... }:
          {
            catppuccin.flavor = "frappe";
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
