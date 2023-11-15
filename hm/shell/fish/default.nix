{ config, pkgs, libs, ... }:
{

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    functions = import ./functions.nix;
    interactiveShellInit = import ./interactiveShellInit.nix;

    shellInit = ''
      source ~/.config/fish/static_variables.fish
      source ~/.config/fish/kubectl_aliases.fish
    '';

    shellAbbrs = {
      "cert" = "openssl x509 -text -noout -in ";
      "ghf" = "gh run list -u (gh-user) -s failure";
      "kx" = "kubectx";
      "kns" = "kubens";
      "gpc" = "gh pr checkout";
      "gpcl" = "gh pr checkout (gh-last-pr)";
      "grb" = "gh repo browse -w";
      "gpcr" = "gh pr create -w";
      "gpv" = "gh pr view -w";
      "c" = "clear";
    };

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
          rev = "f226864d956f8ad056604ca65d37e338ac5930b3";
          sha256 = "sha256-YYSanau67IvnfHn24hWfoM1w2XSLU0isqBqdf/vuGIY=";
        };
      }

      # https://github.com/franciscolourenco/done
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
          sha256 = "sha256-6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
        };
      }

      # https://github.com/tom-doerr/codex.fish
      {
        name = "codex.fish";
        src = pkgs.fetchFromGitHub {
          owner = "tom-doerr";
          repo = "codex.fish";
          rev = "de47a14cabb7e47cc24b6f723362e4795799a893";
          sha256 = "sha256-JTxFYEeRc9IPTuU0rwoWnwd9+IoJ/2WNLVREeMH1C7s=";
        };
      }

      # https://github.com/oh-my-fish/plugin-thefuck
      {
        name = "thefuck";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-thefuck";
          rev = "6c9a926d045dc404a11854a645917b368f78fc4d";
          sha256 = "sha256-9MbkyEsMsZH+3ct7qJSPvLeLRfVkDEkXRTdg/Rhe0dg=";
        };
      }
      {
        name = "foreign-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
    ];

    shellAliases = {
      vim = "nvim";
      ls = "eza";
    };
  };

  # Symlink individually to not point conf.d to nix store
  home.file.".config/fish/static_variables.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/static_variables.fish";
  home.file.".config/fish/kubectl_aliases.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/kubectl_aliases.fish";
  home.file.".config/fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/completions";
}
