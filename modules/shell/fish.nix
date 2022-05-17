{ config, pkgs, libs, ... }:
{

  programs.fish = {
    enable = true;
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
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev= "14a6f2b317661e959e13a23870cf89274f867f12";
          sha256="kl6XR6IFk5J5Bw7/0/wER4+TnQfC18GKxYbt9C+YHJ0=";
        };
      }
    ];

    shellAliases = {
      vim = "nvim";
    };

    shellInit = ''
      set -e VAULT_TOKEN
      set -Ux VAULT_TOKEN (pass 'Vault Token' -sa password)

      if test -z (pgrep ssh-agent)
        eval (ssh-agent -c -a ~/.ssh/agent)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
      end

      source ~/.config/fish/static_variables.fish
    '';
  };


# home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish";

  # Symlink individually to not point conf.d to nix store
#  home.file.".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/config.fish";
  home.file.".config/fish/static_variables.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/static_variables.fish";
  home.file.".config/fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/completions";
  home.file.".config/fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/functions";
}
