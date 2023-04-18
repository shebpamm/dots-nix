{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Erik Karsten";
    userEmail = "erik@opcode.xyz";
    ignores = [
      "*.o"
      ".DS_Store"
      ".nvimrc.lua"
    ];

    aliases = {
      co = "checkout";
      br = "branch";
      st = "status";
      cm = "commit -m";
      amend = "commit --amend";
      dfs = "diff --staged";
      a = "add";
    };

    diff-so-fancy.enable = true;

    extraConfig = {
      safe.directory = "/home/shebpamm/dotfiles";
      init = {
        defaultBranch = "main";
      };

      url = {
        "git://github.com/" = {
          insteadOf = "github:";
        };
        "git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = [ "github:" "git://github.com/" ];
        };
      };
      "credential \"https://github.com\"" = {
        helper = "!${pkgs.github-cli}/bin/gh auth git-credential";
      };
    };
  };
}
