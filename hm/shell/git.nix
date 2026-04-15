{ config, pkgs, ... }:
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
      stashgrep = "!f() { for i in `git stash list --format=\"%gd\"` ; do git stash show -p $i | grep -H --label=\"$i\" \"$@\" ; done ; }; f";
      stashrg = "!f() { for i in `git stash list --format=\"%gd\"` ; do git stash show -p $i | sed \"s/^/$i:/\" | rg \"$@\" ; done ; }; f";
      stashfd = "!f() { for i in `git stash list --format=\"%gd\"`; do git stash show --name-only $i | grep -H --label=\"$i\" \"$@\" ; done ; }; f";
    };

    diff-so-fancy.enable = true;

    extraConfig = {
      safe.directory = "/home/shebpamm/dotfiles";
      stash.showIncludeUntracked = true;
      init = {
        defaultBranch = "main";
      };

      color = {
        ui = true;

        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };

        diff = {
          meta = "11";
          frag = "magenta bold";
          func = "146 bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
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
