{ ... }:
{
  flake.aspects =
    { ... }:
    {
      tmux = {
        homeManager =
          { pkgs, config, ... }:
          {
            home.packages = [ pkgs.tmux ];
            home.file.".tmux.conf.d".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf.d";
            home.file.".tmux/plugins/tpm".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/tpm";
            home.file.".tmux.conf".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/tmux/.tmux.conf";
          };
      };
    };
}
