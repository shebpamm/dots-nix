{ config, pkgs, libs, ... }:
{

  programs.fish = {
    enable = true;

    functions = import ./functions.nix;
    interactiveShellInit = import ./interactiveShellInit.nix;

    shellInit = ''
      source ~/.config/fish/static_variables.fish
    '';

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
          rev = "17233a43be6f56fe402c6d2fee13e2c1243c5ad2";
          sha256="sha256-VJHCcpFrrXpXIf9x1MT3n6SKqHbiBq1e1Dvefe3uEu4=";
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

      # https://github.com/tom-doerr/codex.fish
      {
        name = "codex.fish";
        src = pkgs.fetchFromGitHub {
          owner = "tom-doerr";
          repo = "codex.fish";
          rev= "de47a14cabb7e47cc24b6f723362e4795799a893";
          sha256="sha256-JTxFYEeRc9IPTuU0rwoWnwd9+IoJ/2WNLVREeMH1C7s=";
        };
      }

      # https://github.com/oh-my-fish/plugin-thefuck
      {
        name = "thefuck";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-thefuck";
          rev= "6c9a926d045dc404a11854a645917b368f78fc4d";
          sha256="sha256-9MbkyEsMsZH+3ct7qJSPvLeLRfVkDEkXRTdg/Rhe0dg=";
        };
      }
    ];

    shellAliases = {
      vim = "nvim";
      ls = "exa";
    };
  };

  # Symlink individually to not point conf.d to nix store
  home.file.".config/fish/static_variables.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/static_variables.fish";
  home.file.".config/fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/completions";
}
