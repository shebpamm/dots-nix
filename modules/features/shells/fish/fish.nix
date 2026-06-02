{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      fish = {
        nixos =
          { ... }:
          {
            programs.fish.enable = true;
          };
        homeManager =
          { pkgs, config, ... }:
          {
            programs.fish = {
              enable = true;

              # functions = import ./functions.nix;
              # interactiveShellInit = import ./interactiveShellInit.nix;

              shellInit = ''
                source ~/.config/fish/static_variables.fish
                source ~/.config/fish/kubectl_aliases.fish

                # Source all files in ~/.fish if exists
                if test -d ~/.fish
                    for file in ~/.fish/*.fish
                        if test -e $file
                            source $file
                        end
                    end
                end
              '';

              shellAbbrs = {
                "cert" = "openssl x509 -text -noout -in ";
                "kx" = "kubectx";
                "kns" = "kubens";
                "ssls" = "openssl x509 -noout -text -in ";
                "c" = "clear";
                "ks" = "k9s";
                "ksw" = "k9s --write";
                "xc" = "xclip -selection clipboard ";
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
                    rev = "077081d885f0f813ce642b01d0bfa66be144e395";
                    sha256 = "sha256-iy8okNiZi5JIN6idW92COGDLENLi1O2KbSFbvecXGt4=";
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
                ls = "eza --group-directories-first --icons";
                book = "./run-ansible-playbook.sh -D -e@(ansible-pass | psub)";
                assume = "source ${pkgs.granted}/share/assume.fish";
              };
            };

            home.file =
              let
                dotfiles = inputs.self.context.dotfilesPath;
              in
              {
                ".config/fish/static_variables.fish".source =
                  config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/fish/static_variables.fish";
                ".config/fish/kubectl_aliases.fish".source =
                  config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/fish/kubectl_aliases.fish";
                ".config/fish/completions".source =
                  config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/fish/completions";
              };
          };
      };
    };
}
