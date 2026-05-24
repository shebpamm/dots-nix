{ ... }:
{
  flake.aspects =
    { ... }:
    {
      scripts = {
        nixos =
          { ... }:
          {
            environment.sessionVariables.PATH = [ "\$HOME/.bin" ];
          };

        homeManager =
          { config, ... }:
          {
            home.file.".bin".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
          };
      };
    };
}
