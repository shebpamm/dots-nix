{ config, pkgs, libs, ... }:
{

  programs.fish = {
    enable = true;

    functions = import ./functions.nix;
    interactiveShellInit = import ./interactiveShellInit.nix;

    plugins = [
      # https://github.com/jethrokuan/z
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }

      # https://github.com/oh-my-fish/theme-bobthefish
      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "shebpamm";
          repo = "theme-bobthefish";
          rev = "e591c412d2dc3a47ba97da75e94de2ff70297590";
          sha256="sha256-VKbnxTPuiCG4R6cBd1stweXWRpepqPuAywjZz0/BwO4=";
        };
      }

      # https://github.com/franciscolourenco/done
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev= "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
          sha256="sha256-6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
        };
      }
    ];

    shellAliases = {
      vim = "nvim";
    };
  };

  # Symlink individually to not point conf.d to nix store
  home.file.".config/fish/static_variables.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/static_variables.fish";
  home.file.".config/fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/completions";
}
