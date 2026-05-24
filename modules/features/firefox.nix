{ ... }:
{
  flake.aspects =
    { ... }:
    {
      firefox = {
        homeManager =
          { config, ... }:
          {
            programs.firefox.enable = true;
            programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
          };
      };
    };
}
