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

      push.autoSetupRemote = true;

      url = {
        "https://github.com/" = {
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
