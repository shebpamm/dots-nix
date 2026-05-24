{ ... }:
{
  flake.aspects =
    { ... }:
    {
      scripts = {
        homeManager =
          { config, ... }:
          {
            environment.sessionVariables.PATH = [ "\$HOME/.bin" ];
            home.file.".bin".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
          };
      };
    };
}
