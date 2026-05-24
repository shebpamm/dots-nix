{ ... }:
{
  flake.aspects =
    { ... }:
    {
      zsh = {
        nixos =
          { ... }:
          {
            programs.zsh = {
              enable = true;
              enableCompletion = true;
              enableGlobalCompInit = false;
            };
          };
        homeManager =
          { config, ... }:
          {
            home.file.".zsh".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh/.zsh";
            home.file.".zshrc".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh/.zshrc";
            home.file.".zshenv".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh/.zshenv";
          };
      };
    };
}
